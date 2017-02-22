# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CodCharge.delete_all
CodCharge.create(
    [
        {cod_charge_code:'01',charge:300,start_amount:0, end_amount:10000},
        {cod_charge_code:'04',charge:400,start_amount:10000, end_amount:30000},
        {cod_charge_code:'04',charge:1000,start_amount:30000, end_amount:100000},
        {cod_charge_code:'04',charge:1000,start_amount:100000, end_amount:99999999}
    ])