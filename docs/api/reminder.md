## The Reminder no-API
This aims to be a static data to allow us have k-reminder in the system instead of letting eachfor example dhikr have its how reminder datetime.

When a reminder is created in the system its on the db then next time someone try to create another self reminder we check if not 
already exist then create or link.


Basic Models:
```
Reminder {
    id: int
    remind_at?: datetime
}
```
