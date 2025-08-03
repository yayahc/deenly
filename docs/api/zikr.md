## The Zikr API

### v0
Requirement:
- See commons zikrs
- Choose a zikr to practice
- Set reminder for a zikr and get notification (local first). eg: you set a reminder for a zikr to 10pm then each day at this time you get a notification that tell you to do your dayly zikr with zikr detail.
- Manage you own zikrs  
HINT: share zikrs accros all user. if a zirk exist do not create it, if a reminder for a zikr is alredy set do ne set if. This will reduce amount of rikr and reminder in the db as many users may use same zirk and same reminders.

Basic Models:
```
Zikr {
    id: int
    invocation: list<string> (item is a compute of invocation + his repeate_count)    
    benefice?: string
    remind_at?: Tine
    created_at: DateTime
    updated_at?: DateTime
}
```

Endpoints:

- [GET] zikrs  
Desc : return commons zikrs   
Response : `List<Zirk>`

- [GET] zikr?id=zikr_id  
Desc : return a zikr  
Response : `Zirk`

- [POST] zikrs/subscribe  
Desc : subscribe to practice a zikr  
Request :  {zikr_id, reminder_id, user_token}  

- [POST] zikrs/unsubscribe  
Desc : unsubscribe to a zikr  
Request :  {zikr_id, user_token}  