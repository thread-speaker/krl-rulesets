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
    select when car new_trip mileage "(.*)" setting(m)
    send_directive("trip") with
      trip_length = m;
	
	
    always {
      raise explicit event 'trip_processed'
        attributes event:attrs()
	}
  }
}
