class Api < Raisin::Router
  version :v1 do
    mount V1::UsersApi
     mount V1::PointagesApi
  end
end