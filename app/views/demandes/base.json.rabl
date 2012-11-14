attributes :_id, :_type, :date_creation, :date_depart, :date_retour

child(:user) do
  attributes :id, :email, :name, :solde_conge, :solde_recup
end