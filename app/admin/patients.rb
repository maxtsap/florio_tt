ActiveAdmin.register Patient do
  permit_params :name

  filter :name
  filter :created_at
  filter :injections

  index do
    selectable_column
    column :name
  end

  form do |f|
    f.semantic_errors

    inputs do
      f.input :name
    end

    f.actions
  end
end
