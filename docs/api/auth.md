#### AUTHENTICATOIN

For Auth we use [sign in with google](https://developers.google.com/identity/siwg), so a user is identified in project by its google id token.

By default new user have type user, for now admins will manualy.

### v0
Requirement:
- sign in with google
- logout

Basic User:
```
User {
    token: int
    type: enum(user,admin)
    created_at: DateTime
}
```