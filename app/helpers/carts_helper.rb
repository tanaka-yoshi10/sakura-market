module CartsHelper
  def selected_ship_date
    ship_date = @order.ship_date? ? l(@order.ship_date, format: :long) : '未指定'
    "配達日：" + ship_date
  end

  def selected_ship_time
    ship_time = @order.ship_time_id? ? @order.ship_time.display_name  : '未指定'
    "配達時間：" + ship_time
  end

  def ship_date_list
    @ship_dates = [[nil, '未指定']]
    for d in 3..14 do
      bizDate = d.business_day.from_now
      date = Date.new(bizDate.utc.year, bizDate.utc.month, bizDate.utc.day)
      @ship_dates << [date, "#{l(date, format: :date_only)}"]
    end
    @ship_dates.to_a
  end
end
