ruleset track_trips {
  meta {
    name "Track Trips"
    description <<
ruleset for tracking trips
>>
    author "Aaron Monson"
    logging on
    sharing on
  }
  
  rule process_trip {
    select when echo message mileage "(.*)" setting(m)
    send_directive("trip") with
      trip_length = m;
  }
}
