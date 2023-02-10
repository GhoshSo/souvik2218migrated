# - dashboard: souvik_merged_dash_filter_issue
#   title: Souvik Merged Dash Filter Issue
#   layout: newspaper
#   preferred_viewer: dashboards-next
#   filters_bar_collapsed: true
#   filters_location_top: false
#   description: ''
#   preferred_slug: RRwq70I1BGa3E7JwwQATIR
#   elements:
#   - name: Merged
#     title: Merged
#     merged_queries:
#     - model: souvik2218
#       explore: users
#       type: looker_grid
#       fields: [users.gender, users.state]
#       filters:
#         # users.created_year: 2017/01/01 to 2019/01/01
#       sorts: [users.gender]
#       limit: 500
#       column_limit: 50
#       show_view_names: false
#       show_row_numbers: true
#       transpose: false
#       truncate_text: true
#       hide_totals: false
#       hide_row_totals: false
#       size_to_fit: true
#       table_theme: white
#       limit_displayed_rows: false
#       enable_conditional_formatting: false
#       header_text_alignment: left
#       header_font_size: '12'
#       rows_font_size: '12'
#       conditional_formatting_include_totals: false
#       conditional_formatting_include_nulls: false
#       show_sql_query_menu_options: false
#       column_order: []
#       show_totals: true
#       show_row_totals: true
#       truncate_header: false
#       series_cell_visualizations:
#         users.average_age:
#           is_active: true
#       series_value_format:
#         users.average_age:
#           name: decimal_1
#           decimals: '1'
#           format_string: "#,##0.0"
#           label: Decimals (1)
#           label_prefix: Decimals
#       x_axis_gridlines: false
#       y_axis_gridlines: true
#       show_y_axis_labels: true
#       show_y_axis_ticks: true
#       y_axis_tick_density: default
#       y_axis_tick_density_custom: 5
#       show_x_axis_label: true
#       show_x_axis_ticks: true
#       y_axis_scale_mode: linear
#       x_axis_reversed: false
#       y_axis_reversed: false
#       plot_size_by_field: false
#       trellis: ''
#       stacking: ''
#       legend_position: center
#       point_style: none
#       show_value_labels: false
#       label_density: 25
#       x_axis_scale: auto
#       y_axis_combined: true
#       ordering: none
#       show_null_labels: false
#       show_totals_labels: false
#       show_silhouette: false
#       totals_color: "#808080"
#       defaults_version: 1
#       series_types: {}
#     - model: souvik2218
#       explore: users
#       type: table
#       fields: [users.gender, users.zip, users.average_age, users.count, users.total_age]
#       sorts: [users.average_age desc]
#       limit: 500
#       query_timezone: America/Los_Angeles
#       join_fields:
#       - field_name: users.gender
#         source_field_name: users.gender
#     type: table
#     listen:
#     -
#     - State: users.state
#     row: 0
#     col: 0
#     width: 17
#     height: 8
#   filters:
#   - name: State
#     title: State
#     type: field_filter
#     default_value: Delaware
#     allow_multiple_values: true
#     required: false
#     ui_config:
#       type: tag_list
#       display: popover
#     model: souvik2218
#     explore: users
#     listens_to_filters: []
#     field: users.state
