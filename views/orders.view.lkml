# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  filter: datetime_filter {
    # This will now be the primary field to filter the dates/time for created on hour utc
    view_label: " Calendar"
    label: "Date Filter"
    type: date_time
  }

  parameter: data_end_year {
    type: number
    hidden: yes
    label: "Price Effective End Year"
  }

  dimension: date_dim_year_filter {
    type: number
    hidden: yes
    label: "Date Dim Year Filter Condition"
    sql: CASE WHEN
      {% parameter data_end_year %} IS NULL THEN 1 ELSE 0 END;;
  }

  # dimension_group: created_on_hour_utc{}

  dimension_group: in_period {
    # To count the interval between start and end date
    view_label: " Calendar"
    type: duration
    intervals: [day, hour, week, month, quarter, year]
    sql_start: {% date_start datetime_filter %} ;;
    sql_end: {% date_end datetime_filter %} ;;
    # hidden:  yes
    convert_tz: no
  }
##
  dimension_group: created {
    type: time
    # timeframes: [
    #   raw,
    #   time,
    #   date,
    #   week,
    #   month,
    #   quarter,
    #   year
    # ]
    convert_tz: no
    sql: ${TABLE}.created_at ;;
    #sql: to_timestamp_ntz(${TABLE}.created_at) ;;
#####
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Status" in Explore.

  dimension: status {
    type: string
    sql: ${TABLE}.status;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: created_at_date {
    type: number
    hidden: yes
    label: "Date Dim Year Filter Condition"
    sql: CASE WHEN
      {% parameter data_end_year %} IS NULL THEN 1 ELSE 0 END;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: convert_tz_test {
    type: string
    suggest_persist_for: "0 seconds"
    sql:  CASE WHEN ${id}>100 THEN CONCAT(CONVERT_TZ(${created_raw},'UTC','{{ _query._query_timezone }}'), " ",${id})
             ELSE " "
        END;;
  }

  parameter:color_yesterdays_figures {
    type: string
    allowed_value: {
      label: "Yes"
      value: "yes"
    }
    allowed_value: {
      label: "No"
      value: "no"
    }
    default_value: "yes"
  }

  dimension: status_yesno_Parameter_and_Status {
    type: string
    sql:
        CASE
           WHEN ${status} = 'complete' THEN "yes"
           ELSE "no"
        END ;;
    html: {% if status._value == "pending" and  color_yesterdays_figures._parameter_value == "yes" %}
               <p style='color: black; background-color: #c8e6c8;'>{{rendered_value}}</p>
          {% else %} <font color="darkred">{{ rendered_value }}</font>
          {% endif %};;
  }

  dimension: status_yesno_Only_Status {
    type: string
    sql:
        CASE
           WHEN ${status} = 'complete' THEN "yes"
           ELSE "no"
        END ;;
    html: {% if status._value == "pending" %}
               <p style='color: black; background-color: #c8e6c8;'>{{rendered_value}}</p>
          {% else %} <font color="darkred">{{ rendered_value }}</font>
          {% endif %};;
  }

  dimension: status_yesno_Only_Parameter {
    type: string
    sql:
        CASE
           WHEN ${status} = 'complete' THEN "yes"
           ELSE "no"
        END ;;
    html: {% if color_yesterdays_figures._parameter_value == "yes" %}
               <p style='color: black; background-color: #c8e6c8;'>{{rendered_value}}</p>
          {% else %} <font color="darkred">{{ rendered_value }}</font>
          {% endif %};;
  }


  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      billion_orders.count,
      fakeorders.count,
      hundred_million_orders.count,
      hundred_million_orders_wide.count,
      order_items.count,
      order_items_vijaya.count,
      ten_million_orders.count
    ]
  }
}
