- dashboard: souvik_dashboard_issue
  title: Souvik Dashboard Issue
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: MhxanEVcNyGJHdY9cgbLPG
  elements:
  - title: Souvik Dashboard Issue
    name: Souvik Dashboard Issue
    model: souvik2218
    explore: users
    type: looker_grid
    fields: [users.state, users.average_age, users.created_month]
    pivots: [users.created_month]
    fill_fields: [users.created_month]
    filters: {}
    sorts: [users.created_month desc, users.average_age desc 0]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_cell_visualizations:
      users.average_age:
        is_active: true
    series_value_format:
      users.average_age:
        name: decimal_1
        decimals: '1'
        format_string: "#,##0.0"
        label: Decimals (1)
        label_prefix: Decimals
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Created Year: users.created_year
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Created Year
    title: Created Year
    type: field_filter
    default_value: 2017/01/01 to 2019/01/01
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: souvik2218
    explore: users
    listens_to_filters: []
    field: users.created_year
