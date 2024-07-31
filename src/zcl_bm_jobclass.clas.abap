CLASS zcl_bm_jobclass DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BM_JOBCLASS IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.
* selname  type c length 8
* kind  type c length 1
* datatype  type c length 4
* length  type int4
* decimals  type int4
* component_type  type c length 30
* section_text  type c length 255
* group_text  type c length 255
* param_text  type c length 255
* lowercase_ind  type abap_bool
* hidden_ind  type abap_bool
* changeable_ind  type abap_bool
* mandatory_ind  type abap_bool
* checkbox_ind  type abap_bool
* list_ind  type abap_bool
* radio_group_ind  type abap_bool
* radio_group_id  type c length 4

    et_parameter_def = VALUE #(
        ( selname = 'P_MATNR' kind = if_apj_dt_exec_object=>parameter    component_type = 'MATNR' length = 40 param_text = 'Artikelnummer'   changeable_ind = abap_true )
      ).

    " Return the default parameters values here
    et_parameter_val = VALUE #(
      ( selname = 'P_MATNR' kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = 'A100' )
    ).
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.
* importing it_parameters  type if_apj_rt_exec_object=>tt_templ_val
* raising cx_apj_rt_content
    DATA: lra_matnr TYPE RANGE OF matnr.
    lra_matnr = VALUE #( FOR wa IN it_parameters ( low = wa-low high = wa-high option = wa-option sign = wa-sign ) ).

    SELECT * FROM i_product WHERE Product IN @lra_matnr INTO TABLE @DATA(products) .


  ENDMETHOD.
ENDCLASS.
