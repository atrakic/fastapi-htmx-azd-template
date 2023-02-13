"""main"""

import uuid
from fastapi import Depends
from fastapi import FastAPI, Form
from fastapi import Request, Response
from fastapi.responses import HTMLResponse

from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session

from database import Base
from database import SessionLocal
from database import engine

from models import create_todo, delete_todo, get_todo, get_todos, update_todo

Base.metadata.create_all(bind=engine, checkfirst=True)

app = FastAPI(
    description="Todo API",
)

templates = Jinja2Templates(directory="templates")


def get_db():
    db_name = SessionLocal()
    try:
        yield db_name
    finally:
        db_name.close()


@app.get("/", response_class=HTMLResponse)
def home(request: Request, db_name: Session = Depends(get_db)):
    session_key = request.cookies.get("session_key", uuid.uuid4().hex)
    todos = get_todos(db_name, session_key)
    context = {"request": request, "todos": todos, "title": "Home"}
    response = templates.TemplateResponse("home.html", context)
    response.set_cookie(key="session_key", value=session_key, expires=259200)  # 3 days
    return response


@app.post("/add", response_class=HTMLResponse)
def post_add(
    request: Request, content: str = Form(...), db_name: Session = Depends(get_db)
):
    session_key = request.cookies.get("session_key")
    todo = create_todo(db_name, content=content, session_key=session_key)
    context = {"request": request, "todo": todo}
    return templates.TemplateResponse("todo/item.html", context)


@app.get("/edit/{item_id}", response_class=HTMLResponse)
def get_edit(request: Request, item_id: int, db_name: Session = Depends(get_db)):
    todo = get_todo(db_name, item_id)
    context = {"request": request, "todo": todo}
    return templates.TemplateResponse("todo/form.html", context)


@app.put("/edit/{item_id}", response_class=HTMLResponse)
def put_edit(
    request: Request,
    item_id: int,
    content: str = Form(...),
    db_name: Session = Depends(get_db),
):
    todo = update_todo(db_name, item_id, content)
    context = {"request": request, "todo": todo}
    return templates.TemplateResponse("todo/item.html", context)


@app.delete("/delete/{item_id}", response_class=Response)
def delete(item_id: int, db_name: Session = Depends(get_db)):
    delete_todo(db_name, item_id)
