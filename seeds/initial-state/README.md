# Initial state dataset

This dataset aims at providing an example of "initial state" for the PIPAS
system. It contains,

* 1 treatment plan, FEC chemotherapy: 6x (Treatment then Rest for 20 days)
* 7 patients, the researchers of the PIPAS project
* 7 prescribed treatments, one for each patient, diagnosis on 2013-12-31,
  earliest start date from 15 to 25 days from diagnosis date and latest start
  date 15 days after the earliest start date
* No cure prescription, no delivery, no appointment yet
* Bed and nurse availabilities (more on wednesdays, less on saturdays, nothing on sundays)
* No patient unavailability

We suppose that the schedule has been computed at "2014-01-01 12:00:00". No
change has been made since then, so the accuracy timestamp has the same value.
