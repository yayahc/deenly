## The Goal API

### v0
Requirement:
- Set a streak goal
- Get streak (community support : mean you can see others people goal if they accept it to be public)
- Update streak
- Remove streak

Basic Models:
```
Goal {
    id: int
    description: string
    isPrivate: bool
    streak: int (if market as done then increase the streak count)
    created_at: DateTime
}
```

Endpoints:

- [GET] goals
Desc: return all public goals
Response: `List<Goal>`

- [GET] goal?id=goal_id
Desc: return a goal
Response: `Goal`

- [GET] goals/me
Desc: return user goals
Response: `List<Goal>`

- [POST] goal/set
Desc: set a goal (if done requried to create the goal first then use its id to set)
Request: {goal_id, user_token}

- [DELETE] goal/unset
Desc: un-seta goal
Request: {goal_id, user_token}
