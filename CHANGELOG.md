# v0.2.0 -- FIX ME

According to changes agreed at the PIPAS meeting on 28th of January 2014.

* Removed `treatments/appointments/appointment_id` from `/scheduling/problem`.

* Removed `service/rdi`, `treatments/appointments/appointment_id' and
  `treatments/appointments/fixed` from `/scheduling/solution`.

* Clarified the fact that RDI is a float between 0.0 and 1.0

* Changed the representations of loads and durations to be minutes instead of
  hours/days. In `/scheduling/problem`
    * `service/hours_per_day` is now `service/minutes_per_day` and `quantity` a number of minutes.
    * `treatments/treatment_plan/duration` is the total treatment duration in minutes.
    * `.../steps/duration` is always in minute too. Delivery steps have a duration that equals the bed load (see below).
    * `.../steps/bed_load` and `nurse_load` are expressed in minutes too.
  Please note that bed and nurse _availabilities_ is `service/...` are NOT affected by this change.

# v0.1.0 -- 2014-01-27

Initial release.