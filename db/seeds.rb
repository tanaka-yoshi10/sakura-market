# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CodCharge.delete_all
CodCharge.create([
  {cod_charge_code:'01',charge:300,start_amount:0, end_amount:10000},
  {cod_charge_code:'04',charge:400,start_amount:10000, end_amount:30000},
  {cod_charge_code:'04',charge:1000,start_amount:30000, end_amount:100000},
  {cod_charge_code:'04',charge:1000,start_amount:100000, end_amount:99999999}
])
ShipTime.delete_all
ShipTime.create([
  {shiptime_code: '01', display_name: '8時〜12時'},
  {shiptime_code: '02', display_name: '12時〜14時'},
  {shiptime_code: '03', display_name: '14時〜16時'},
  {shiptime_code: '04', display_name: '16時〜18時'},
  {shiptime_code: '05', display_name: '18時〜20時'},
  {shiptime_code: '06', display_name: '20時〜21時'},
  {shiptime_code: '00', display_name: '未指定'},
])
User.delete_all
User.create([
  {email: 'admin@mail.jp', name: '管理者', password_digest: '$2a$10$BH.IQxzd3kEWbHAuHDEWgedl2XW/2zcSV82L0VVuU6DYZlBri77D2'}
])