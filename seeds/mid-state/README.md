# Mid state dataset

This datasets inherits from the initial state and illustrates the following
situation (order of temporal events):

* the scheduler computed an initial scheduling for every treatment
* the first appointment has been communicated ('fixed') to all patient
* the first patient also communicated an unavailability the 2014-02-05, which
  corresponds to the current date of his second appointment (not fixed)

We suppose that the schedule has been computed at "2014-01-01 12:00:00" and not
revised since them. However, the patient communicated its unavailability at
"2014-01-01 12:15:00" and that it's the last seen change. The accuracy
timestamp therefore reflects this time.
