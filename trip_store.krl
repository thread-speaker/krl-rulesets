
ruleset trip_store {
  meta {
    name "Trip Store"
    description <<
ruleset for part 3 of the single pico lab
>>
    author "Aaron Monson"
    logging on
    sharing on
  }
  
  global { }
  
  rule collect_trips {
    select when explicit trip_processed mileage "(.+)" setting(m)
    send_directive("gotIt")
    always {
      set ent:trips []
    }
  }
  
  rule collect_long_trips {
    select when explicit found_long_trip mileage "(.+)" setting(m)
    send_directive("gotIt")
    always {
      set ent:trips []
    }
  }
  
  rule clear_trips {
    select when car trip_reset
    send_directive("gotIt")
    always {
      set ent:trips []
    }
  }
}
