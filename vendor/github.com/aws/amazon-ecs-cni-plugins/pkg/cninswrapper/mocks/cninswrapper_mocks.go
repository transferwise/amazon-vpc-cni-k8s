// Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License"). You may
// not use this file except in compliance with the License. A copy of the
// License is located at
//
//     http://aws.amazon.com/apache2.0/
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.

// Automatically generated by MockGen. DO NOT EDIT!
// Source: github.com/aws/amazon-ecs-cni-plugins/pkg/cninswrapper (interfaces: NS)

package mock_cninswrapper

import (
	"github.com/containernetworking/cni/pkg/ns"
	gomock "github.com/golang/mock/gomock"
)

// Mock of NS interface
type MockNS struct {
	ctrl     *gomock.Controller
	recorder *_MockNSRecorder
}

// Recorder for MockNS (not exported)
type _MockNSRecorder struct {
	mock *MockNS
}

func NewMockNS(ctrl *gomock.Controller) *MockNS {
	mock := &MockNS{ctrl: ctrl}
	mock.recorder = &_MockNSRecorder{mock}
	return mock
}

func (_m *MockNS) EXPECT() *_MockNSRecorder {
	return _m.recorder
}

func (_m *MockNS) GetNS(_param0 string) (ns.NetNS, error) {
	ret := _m.ctrl.Call(_m, "GetNS", _param0)
	ret0, _ := ret[0].(ns.NetNS)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockNSRecorder) GetNS(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "GetNS", arg0)
}

func (_m *MockNS) WithNetNSPath(_param0 string, _param1 func(ns.NetNS) error) error {
	ret := _m.ctrl.Call(_m, "WithNetNSPath", _param0, _param1)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockNSRecorder) WithNetNSPath(arg0, arg1 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "WithNetNSPath", arg0, arg1)
}
