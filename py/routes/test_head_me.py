# -*- coding: utf-8 -*-

import pytest
from base_api_utils import BaseApiUtils


class TestBAUHeadMe:
    @pytest.fixture
    def bau(self, cfg):
        self.URL = cfg["base_url"] + '/head-me'
        self.DEFAULT_ERR_BODY = cfg["default_err_body"]
        self.EXPECTED_BODY = {"message": "headed"} 
        self.EXPECTED_ALLOW_VALUES = ['HEAD', 'OPTIONS']
        return BaseApiUtils(cfg)

    def test_head_me_delete(self, bau):
        rsp = bau.delete_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body=self.DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg

    def test_head_me_get(self, bau):
        rsp = bau.get_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body=self.DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg

    def test_head_me_head(self, bau):
        rsp = bau.head_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=200)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body='')
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg

    def test_head_me_options(self, bau):
        rsp = bau.options_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=200)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body='')
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='text/html'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg

    def test_head_me_patch(self, bau):
        rsp = bau.patch_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body=self.DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg

    def test_head_me_post(self, bau):
        rsp = bau.post_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body=self.DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg

    def test_head_me_put(self, bau):
        rsp = bau.put_it(self.URL)
        bool, msg = bau.check_response_status_code(rsp=rsp, expected_status_code=405)
        assert bool, msg
        bool, msg = bau.check_response_body(rsp=rsp, expected_body=self.DEFAULT_ERR_BODY)
        assert bool, msg
        bool, msg = bau.check_response_content_type(
            rsp=rsp,
            expected_header_value='application/json'
        )
        assert bool, msg
        for allow_val in self.EXPECTED_ALLOW_VALUES: 
            bool, msg = bau.check_response_allow_methods(
                rsp=rsp,
                expected_header_value=allow_val
            )
            assert bool, msg
