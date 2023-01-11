view: topten {
  derived_table: {
    sql: SELECT
          orders.status AS `orders.status`,
              (DAYOFYEAR(orders.created_at )) AS `orders.created_day_of_year`,
          COUNT(DISTINCT orders.id) AS `orders.count`,
          ROW_NUMBER() OVER (PARTITION BY orders.status ORDER BY COUNT(DISTINCT orders.id)) as 'rn'
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      WHERE (orders.status) IS NOT NULL
      GROUP BY
          1,
          2
      ORDER BY
          COUNT(DISTINCT orders.id ) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: rn {
    type: string
    primary_key: yes
    sql: ${TABLE}.`rn` ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.`orders.status` ;;
  }

  dimension: orders_created_day_of_year {
    type: number
    sql: ${TABLE}.`orders.created_day_of_year` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  set: detail {
    fields: [orders_status, orders_created_day_of_year, orders_count]
  }
}
