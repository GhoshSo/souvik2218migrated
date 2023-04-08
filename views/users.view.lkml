# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.users ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;
    value_format: "[>=1000]0.000,\" K\";0.##"
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: total_avreage_age{
    type: number
    sql: ${average_age}+${total_age} ;;
  }

  measure: xx {
    type: number
    sql: ${id}+${count} ;;
    html: <d>{{count._value}}</d> ;;
    }


  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: city_sub {
    type: string
    sql: CASE WHEN SUBSTRING(${city},1,1) = "S" then SUBSTRING(${city},1,1) ELSE ${city} END ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_monthA {
    type: date_day_of_month
    sql: ${created_month} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: created_at_date {
    type: string
    sql: ${created_date} ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: mkc {
    type: string
    sql: substring(${first_name},2,length(${first_name})-1) ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_null_test {
    type: string
    sql: CASE
      WHEN ${gender} IS NOT NULL THEN " "
      ELSE ${gender}
      END ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    html: "<a title={{users.state._rendered_value}}> {{ rendered_value | value | strip_html }} </a>";;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: all_concat {
    type: string
    sql: concat(${email}, " ",${zip}," ",${state}, " ",${last_name}, " ",${first_name}, " ",${mkc}, " ",${city}, " ",${age}) ;;
    html: "<a title={{users.all_concat._rendered_value}}> {{ rendered_value | value | strip_html }} </a>";;
  }

  measure: state_count {
    type: count
    sql: ${state} ;;
  }



  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }
}
