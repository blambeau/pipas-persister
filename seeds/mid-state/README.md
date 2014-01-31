# Mid state dataset

This datasets inherits from the initial state and illustrates the following
situation (order of temporal events):

* the scheduler computed an initial scheduling for every treatment the
  2014-01-01 at 12:00. By simplicity, we suppose that it did not schedule
  since then.
* the first appointment has been communicated ('fixed') to all patient.
* the first patient also communicated an unavailability for the 2014-02-05,
  which corresponds to the current date of his second appointment (not fixed).
  The accuracy timestamp therefore reflects this time.
* treatments get prescribed an delivered the 2014-01-15, some dose reductions
  and delivery problems can be observed (i.e. problems are reflected by the
  delivered dose that sometimes does not match the prescribed dose).
* we are now the 2014-01-20 in the morning (approximately 09:45) and two
  prescriptions have been made, but deliveries are still waiting.

