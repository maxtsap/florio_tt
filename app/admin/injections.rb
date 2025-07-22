ActiveAdmin.register Injection do
  permit_params :dose, :lot_number, :patient_id, :drug_id
end
