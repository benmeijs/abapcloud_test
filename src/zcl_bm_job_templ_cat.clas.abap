CLASS zcl_bm_job_templ_cat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BM_JOB_TEMPL_CAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "https://help.sap.com/docs/btp/sap-business-technology-platform/creating-job-template

    " Create job catalog entry (corresponds to the former report incl. selection parameters)
    DATA(applicationjobhelper) = cl_apj_dt_create_content=>get_instance( ).
    TRY.
        applicationjobhelper->create_job_cat_entry(
            iv_catalog_name       = CONV #( 'ZBM_JOB_CATALOG_TST' )
            iv_class_name         = CONV #( 'ZCL_BM_JOBCLASS' )
            iv_text               = CONV #( 'Ben maakt een Job Catalog voor de eerste keer')
            iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
            iv_transport_request  = CONV #( 'LC5K900079' )
            iv_package            = CONV #( 'ZBM_PACKAGE' )
        ).
        out->write( |Het is gelukt met die catalog| ).

      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
        out->write( |de catalog kon niet worden gemaakt: { lx_apj_dt_content->get_text( ) }| ).
    ENDTRY.
    " Create job template (corresponds to the former system selection variant) which is mandatory
    " to select the job later on in the Fiori app to schedule the job
    NEW zcl_bm_jobclass(  )->if_apj_dt_exec_object~get_parameters(
      IMPORTING
        et_parameter_def = DATA(parameter_definition)
        et_parameter_val = DATA(parameter_values)
    ).
    TRY.
        applicationjobhelper->create_job_template_entry(
            iv_template_name     = CONV #( 'ZBM_JOB_TEMPLATE_TST' )
            iv_catalog_name      = CONV #( 'ZBM_JOB_CATALOG_TST' )
            iv_text              = CONV #(  'Ben maakt zijn eerste job template' )
            it_parameters        = parameter_values
            iv_transport_request  = CONV #( 'LC5K900079' )
            iv_package            = CONV #( 'ZBM_PACKAGE' )
        ).
        out->write( |Het is ook gelukt met die Job template| ).

      CATCH cx_apj_dt_content INTO lx_apj_dt_content.
        out->write( |Het is dus niet gelukt met de job template: { lx_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
