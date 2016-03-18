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
  
  global {
    long_trip = 1200;
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
  
  rule find_long_trips {
    select when explicit trip_processed mileage "(.*)" setting(m)
    if m > long_trip then
      send_directive("done");
    fired {
      raise explicit event 'found_long_trip' attributes event:attrs()
    } else {
    }
  }
}
