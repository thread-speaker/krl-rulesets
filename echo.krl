ruleset echo {
  meta {
    name "Echo"
    description <<
the echo ruleset
>>
    author "Aaron Monson"
    logging on
    sharing on
    provides echo
  }

  rule hello_world is active {
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
