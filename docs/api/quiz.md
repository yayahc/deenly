## The Quiz API

This feat allow admins to set quiz and user to take them.
For now no point system you just take quiz.

### v0
Requirement:
- Set quiz (admin)
- Take quiz
- Update quiz (admin)
- Remove quiz (admin)

Basic Models:
```
Quiz {
    id: int
    question: string
    response: list<string>
    created_at: DateTime
}
```

Endpoints:

- [GET] quizes
Desc: return all quizes
Response: `List<Quiz>`

- [GET] quizes?id=quiz_id
Desc: return a quiz
Response: `Quiz`

- [POST] quizes
Desc: set a quiz
Request: {question, responses, user_token}

- [PATCH] quizes
Desc: update a quiz element
Request: {question, responses, user_token}

- [DELETE] quizes
Desc: delete a quiz
Request: {quiz_id, user_token}

