# v0.5.2 -- 2014-04-29

* Removed the last rest step of the test treatment plan.
* Document the seeding service.
* Added a dataset with 200 patients to be scheduled.

# v0.5.1 -- 2014-03-27

* Added `appointment_id` to /service/planning and /treatment/singular

# v0.5.0 -- 2014-03-04

* Added GET/POST/PUT for treatments, deliveries and appointments.
* Added GET /service/availabilities.
* Added GET /treatment-plans/
* Added `earliest_start_date` and `latest_change_date` in treatments from `/service/planning`

# v0.4.1 -- 2014-02-17

* Added `reference_dose` to treatment plan steps in /scheduling/problem
* Added `tplan_id` and `patient_id` to /service/planning

# v0.4.0 -- 2014-02-07

* Added dose information in `/scheduling/problem` on an appointment basis.
* Implemented PUT /scheduling/solution
* Added support for optional attributes in resource schema, those with a name
  ending with '(?)'.

# v0.3.0 -- 2014-01-31

* Added `/service/planning` resource.

# v0.2.0 -- 2014-01-30

According to changes agreed at the PIPAS meeting (28th of January 2014).

* Added `current_time` in `/scheduling/problem` that serves the current server
  time.

* To avoid serious redundancy in `/scheduling/problem`, treatment plans are
  now provided in `service/treatment_plans` rather than repeated in every
  treatment. The treatment plan of each treatment if referenced through its
  uuid in `treatments/tplan_id`.

* Removed `treatments/appointments/appointment_id` from `/scheduling/problem`.

* Removed `service/rdi`, `treatments/appointments/appointment_id` and
  `treatments/appointments/fixed` from `/scheduling/solution`.

* Clarified the fact that RDI is a float between 0.0 and 1.0

* Changed the representations of loads and durations to be minutes instead of
  hours/days. In `/scheduling/problem`
    * `service/hours_per_day` is now `service/minutes_per_day` and `quantity` a number of minutes.
    * `treatments/treatment_plan/duration` is the total treatment duration in minutes.
    * `.../steps/duration` is always in minutes too. Delivery steps have a duration that equals the bed load (see below).
    * `.../steps/bed_load` and `nurse_load` are expressed in minutes too.
  Please note that bed and nurse _availabilities_ in `service/...` are NOT affected by this change.

* To avoid confusion with real delivered dose, the notion of 'should be'
  delivered dose has been renamed `reference_dose` in treatment plans and
  their steps (i.e. `service/treatment_plans(/steps)/reference_dose`).

# v0.1.0 -- 2014-01-27

Initial release.