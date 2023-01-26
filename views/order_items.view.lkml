# The name of this view in Looker is "Order Items"
view: order_items {

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }


  parameter: sale_price_metric_picker {
    description: "Use with the Sale Price Metric measure"
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "total_sale_price"
    }
    allowed_value: {
      label: "Average Sale Price"
      value: "average_sale_price"
    }
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

  measure: dynamic_measure {
    type: number
    sql:
    {% if sale_price_metric_picker._parameter_value == 'total_sale_price' %}
    ${total_sale_price}
    {% else %}
    ${average_sale_price}
    {% endif %}
    ;;
  }
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;
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
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    link: {
      label: "view on admin"
      url: "https://gcpl2218.cloud.looker.com/explore/souvik2218/order_items?fields=order_items.id&limit=500&vis=%7B%7D&filter_config=%7B%7D&origin=share-expanded"

    }
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: date_formatted {
    sql: ${returned_date} ;;
    html:{{ rendered_value | date: "%b %d, %Y" }};;
  }

  dimension: month_returned {
    # type: date_month
    sql: ${returned_month} ;;
    html:  {{ rendered_value | date: "%B, %Y" }};;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  measure: min_sale_price {
    type: min
    sql: ${sale_price} ;;
    group_label: "Box Plot of Sale Price"
    value_format_name: usd
  }

  measure: max_sale_price {
    type: max
    sql: ${sale_price} ;;
    group_label: "Box Plot of Sale Price"
    value_format_name: usd
  }

  measure: first_quartile_sale_price {
    type: percentile
    percentile: 25
    sql: ${sale_price} ;;
    group_label: "Box Plot of Sale Price"
    value_format_name: usd
  }

  measure: median_sale_price {
    type: median
    sql: ${sale_price} ;;
    group_label: "Box Plot of Sale Price"
    value_format_name: usd
  }

  measure: third_quartile_sale_price {
    type: percentile
    percentile: 75
    sql: ${sale_price} ;;
    group_label: "Box Plot of Sale Price"
    value_format_name: usd
  }



  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
