ruleset trip_store {
  meta {
    name "Trip Store"
    description <<
ruleset for part 3 of the single pico lab
>>
    author "Aaron Monson"
    logging on
    sharing on
    provides trips, long_trips, short_trips
  }
  
  global {
    trips = function() {
      ent:trips
    }
    long_trips = function() {
      ent:long_trips
    }
    short_trips = function() {
      ent:trips.filter(function(trip){
        //includes element x if true
        ent:long_trips.all(function(long_trip){
          trip neq long_trip
        })
      })
    }
  }
  
  rule collect_trips {
    select when explicit trip_processed mileage "(.+)" setting(m)
    if (ent:trips eq 0) then
      send_directive("collected first long trip")
    fired {
      set ent:trips ["" + m + ":" + time:now()]
    }
    else {
      set ent:trips ent:trips.append(["" + m + ":" + time:now()])
    }
  }
  
  rule collect_long_trips {
    select when explicit found_long_trip mileage "(.+)" setting(m)
    if (ent:long_trips eq 0) then
      send_directive("collected first long trip")
    fired {
      set ent:long_trips ["" + m + ":" + time:now()]
    }
    else {
      set ent:long_trips ent:long_trips.append(["" + m + ":" + time:now()])
    }
  }
  
  rule clear_trips {
    select when car trip_reset
    send_directive("gotIt")
    always {
      set ent:trips [];
      set ent:long_trips [];
    }
  }
}
