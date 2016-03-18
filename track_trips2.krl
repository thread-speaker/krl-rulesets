ruleset track_trips {
  meta {
    name "Track Trips 2"
    description <<
ruleset for part 2 of the single pico lab
>>
    author "Aaron Monson"
    logging on
    sharing on
  }
  
  rule process_trip {
    select when car new_trip mileage "(.+)" setting(m)
    send_directive("trip") with
      trip_length = m;
	
	
    always {
      raise explicit event 'trip_processed'
        attributes event:attrs()
	}
  }
}
