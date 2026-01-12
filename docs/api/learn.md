## The Learn API

This feat allwo admins to set things to learn can be *
its connected to the [Quiz](./quizz.md) feat basicaly a quiz can be 
transform (what 1+1?=> 1+1=2).
A learn element can have type lesson, full course, quiz...
For now lets do type quiz mean its a quiz transformed to be lean.

### v0
Requirement:
- Set learn element (admin)
- Get learn element
- Update learn element (admin)
- Remove learn element (admin)

Basic Models:
```
Learn {
    id: int
    content: dynamic (base on type)
    type: enum(quiz)
    created_at: DateTime
}
```
```
QuizLearn {
    id: int
    text: string
    reference: int0int #102 mean surah:1 verse:2   
    created_at: DateTime
}
```

Endpoints:

- [GET] learns
Desc: return all public learns
Response: `List<Learn>`

- [GET] learns?id=learn_id
Desc: return a learn element
Response: `Learn`

- [POST] learns
Desc: set a learn element
Request: {type, content, user_token}

- [DELETE] learns
Desc: un-seta goal
Request: {learn_id, user_token}
