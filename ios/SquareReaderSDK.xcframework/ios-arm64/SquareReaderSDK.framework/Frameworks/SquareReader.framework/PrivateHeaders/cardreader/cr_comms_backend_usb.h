// Copyright (c) 2015 Square, Inc. All rights reserved.

#pragma once

#include <cardreader/cr_cardreader.h>
#include <cardreader/cr_comms_backend.h>

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

typedef struct cr_comms_backend_usb_t cr_comms_backend_usb_t;

typedef void (*cr_comms_backend_usb_send_hid_report_cb_t)(void * context, void const *data, size_t length);

typedef struct cr_comms_backend_usb_cfg_t
{
    // send_hid_report_cb is invoked when LCR needs to send data to the reader.
    cr_comms_backend_usb_send_hid_report_cb_t send_hid_report_cb;
    // Timer api callbacks.
    crs_timer_api_t timer_api;
    // Size of the IN/OUT HID reports to/from the reader.
    size_t report_size;
    // cb_ctx holds a user specified pointer that will be passed as the first argument to
    // callbacks
    void *cb_ctx;
} cr_comms_backend_usb_cfg_t;


cr_comms_backend_usb_t *cr_comms_backend_usb_alloc(void);
cr_comms_backend_result_t cr_comms_backend_usb_free(cr_comms_backend_usb_t *backend);

cr_comms_backend_result_t cr_comms_backend_usb_init(cr_comms_backend_usb_t *backend, cr_comms_backend_usb_cfg_t *cfg);
void cr_comms_backend_usb_shutdown(cr_comms_backend_usb_t *backend);

void cr_comms_backend_usb_build_api(cr_comms_backend_usb_t* backend, cr_comms_backend_api_t *api);

// Process data sent by the reader to LCR.
cr_comms_backend_result_t cr_comms_backend_usb_recv_hid_report_from_reader(cr_comms_backend_usb_t *backend,
                                                                           void const *data,
                                                                           size_t length);

