require 'path'
require 'uuid'

patients = (Path.dir/'07-patients.json').load
tplans   = (Path.dir/'04-treatment-plans.json').load

uuid = UUID.new

# { 
#   "treatment_id": "d9026fa0-66ff-0131-38cb-3c07545ed162",
#   "tplan_id": "bae04d10-66fb-0131-38cb-3c07545ed162",
#   "patient_id": "a12b1870-66fa-0131-38cb-3c07545ed162",
#   "diagnosis_date": "2013-12-31",
#   "earliest_start_date": "2014-01-15",
#   "latest_start_date": "2014-02-01"
# },

treatments = patients.map{|p|
  {
    treatment_id: uuid.generate,
    tplan_id: tplans.sample["tplan_id"],
    patient_id: p["patient_id"],
    diagnosis_date: "2014-03-27",
    earliest_start_date: "2014-03-27",
    latest_start_date: "2014-04-27"
  }
}
puts treatments.to_json