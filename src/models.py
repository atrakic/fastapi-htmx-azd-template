"""models.py"""
from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy.orm import Session

from database import Base


class ToDo(Base):
    __tablename__ = "todos"

    id = Column(Integer, primary_key=True, index=True)
    content = Column(String)
    session_key = Column(String)

    def get_table_name(self):
        print(f"Using {self.__tablename__}")

    def get_session_key(self):
        print(f"Using {self.session_key}")


def create_todo(db_name: Session, content: str, session_key: str):
    todo = ToDo(content=content, session_key=session_key)
    db_name.add(todo)
    db_name.commit()
    db_name.refresh(todo)
    return todo


def get_todo(db_name: Session, item_id: int):
    return db_name.query(ToDo).filter(ToDo.id == item_id).first()


def update_todo(db_name: Session, item_id: int, content: str):
    todo = get_todo(db_name, item_id)
    todo.content = content
    db_name.commit()
    db_name.refresh(todo)
    return todo


def get_todos(db_name: Session, session_key: str, skip: int = 0, limit: int = 100):
    return (
        db_name.query(ToDo)
        .filter(ToDo.session_key == session_key)
        .offset(skip)
        .limit(limit)
        .all()
    )


def delete_todo(db_name: Session, item_id: int):
    todo = get_todo(db_name, item_id)
    db_name.delete(todo)
    db_name.commit()
