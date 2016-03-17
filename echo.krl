ruleset echo {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Aaron Monson"
    logging on
    sharing on
    provides hello
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
  rule hello_world {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  rule echo is active {
    select when echo message input "(.*)" setting(m)
    send_directive("say") with
      something = m;
  }
}
