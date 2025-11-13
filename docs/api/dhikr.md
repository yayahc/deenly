## The Dhikr API

### v0
Requirement:
- See commons dhikrs 
- Choose a dhikr to practice
- Set reminder for a dhikr and get notification (local first). eg: you set a reminder for a dhikr to 10pm then each day at this time you get a notification that tell you to do your daily dhikr with dhikr detail.
- Manage you own dhikrs  
HINT: share dhikrs accros all user. if a dhirk exist do not create it, if a reminder for a zikr is alredy set do ne set if. This will reduce amount of dhikr and reminder in the db as many users may use same dhirk and same reminders.

Basic Models:
```
Dhikr {
    id: int
    invocation: list<string> (item is a compute of invocation + his repeate_count)    
    benefice?: string
    remind_at?: Tine
    created_at: DateTime
    updated_at?: DateTime
}
```

Endpoints:

- [GET] dhikrs  
Desc : return commons dhikrs   
Response : `List<Dhirk>`

- [GET] dhikr?id=dhikr_id  
Desc : return a dhikr  
Response : `Dhirk`

- [POST] dhikrs/subscribe  
Desc : subscribe to practice a dhikr  
Request :  {dhikr_id, reminder_id, user_token}  

- [POST] dhikrs/unsubscribe  
Desc : unsubscribe to a dhikr  
Request :  {dhikr_id, user_token}  
