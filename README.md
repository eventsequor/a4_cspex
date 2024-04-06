# A4Cspex

@autor Eder Leandro Carbonero Baquero

## CSP Communicationg sequential processes

This is a room that allow to implemented the library CSP, we can add user, delete they and write message in the room, all information in keeping in memory. 


## How to compile and start to use in console
Execute the next command then follow the steps in the [Explanation used](#Explanation-used)
```shell
iex -S mix
```

## Explanation used

```shell
# Start Chat is mandatory execute this method before all
Chat.start()

# Define some user
user = "MyFirstUser"

# Add user to chat or register it
Chat.add_user(user)

# Writte some message on the Room Chat
# Send the user and message
Chat.write_message(user. "This is my first message")

# Delete user
Chat.user_delete(user)

# If you want to look the chat information you can execute, this return a struct of the room with the last information registered 
RoomManager.get_room()
```



## Example use console output

```shell
iex(1)> Chat.start
Processing Channel.get/1 method waiting message
{:ok, #PID<0.199.0>, :single_channel}

iex(2)> user = "MyFirstUser"
"MyFirstUser"

iex(3)> Chat.add_user user
:ok

iex(4)> RoomManager.get_room
%Room{name: "Room01", participans: ["MyFirstUser"], message: []}

iex(5)> Chat.write_message user, "My first message"
INFO: The participan is connect and is append a message
:ok

iex(6)> RoomManager.get_room
%Room{
  name: "Room01",
  participans: ["MyFirstUser"],
  message: ["Name participan: MyFirstUser -:- TimeStamp: 1712370371495 -:- Message: My first message"]
}

iex(7)> Chat.add_user user
INFO: The participan is already connected: MyFirstUser
:ok

iex(8)> RoomManager.get_room
%Room{
  name: "Room01",
  participans: ["MyFirstUser"],
  message: ["Name participan: MyFirstUser -:- TimeStamp: 1712370371495 -:- Message: My first message"]
}

iex(9)> Chat.user_delete user
:ok

iex(10)> RoomManager.get_room
%Room{
  name: "Room01",
  participans: [],
  message: ["Name participan: MyFirstUser -:- TimeStamp: 1712370371495 -:- Message: My first message"]
}

iex(11)> Chat.write_message user, "The user is not connected"
ERROR: The participan <MyFirstUser> should be connected to the room before to post
:ok
```

## Installation

** TODO is pending to public this project is not available yet**
 
If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `a4_cspex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:a4_cspex, "~> 0.1.0"}
  ]
end
```
