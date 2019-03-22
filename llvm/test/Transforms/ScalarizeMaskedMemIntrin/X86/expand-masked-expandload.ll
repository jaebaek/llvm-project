; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S %s -scalarize-masked-mem-intrin -mtriple=x86_64-linux-gnu | FileCheck %s

define <2 x i64> @scalarize_v2i64(i64* %p, <2 x i1> %mask, <2 x i64> %passthru) {
; CHECK-LABEL: @scalarize_v2i64(
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i1> [[MASK:%.*]], i64 0
; CHECK-NEXT:    br i1 [[TMP1]], label [[COND_LOAD:%.*]], label [[ELSE:%.*]]
; CHECK:       cond.load:
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, i64* [[P:%.*]], align 1
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x i64> [[PASSTHRU:%.*]], i64 [[TMP2]], i64 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i64, i64* [[P]], i32 1
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[RES_PHI_ELSE:%.*]] = phi <2 x i64> [ [[TMP3]], [[COND_LOAD]] ], [ [[PASSTHRU]], [[TMP0:%.*]] ]
; CHECK-NEXT:    [[PTR_PHI_ELSE:%.*]] = phi i64* [ [[TMP4]], [[COND_LOAD]] ], [ [[P]], [[TMP0]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <2 x i1> [[MASK]], i64 1
; CHECK-NEXT:    br i1 [[TMP5]], label [[COND_LOAD1:%.*]], label [[ELSE2:%.*]]
; CHECK:       cond.load1:
; CHECK-NEXT:    [[TMP6:%.*]] = load i64, i64* [[PTR_PHI_ELSE]], align 1
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <2 x i64> [[RES_PHI_ELSE]], i64 [[TMP6]], i64 1
; CHECK-NEXT:    br label [[ELSE2]]
; CHECK:       else2:
; CHECK-NEXT:    [[RES_PHI_ELSE3:%.*]] = phi <2 x i64> [ [[TMP7]], [[COND_LOAD1]] ], [ [[RES_PHI_ELSE]], [[ELSE]] ]
; CHECK-NEXT:    ret <2 x i64> [[RES_PHI_ELSE3]]
;
  %ret = call <2 x i64> @llvm.masked.expandload.v2i64.p0v2i64(i64* %p, <2 x i1> %mask, <2 x i64> %passthru)
  ret <2 x i64> %ret
}

define <2 x i64> @scalarize_v2i64_ones_mask(i64* %p, <2 x i64> %passthru) {
; CHECK-LABEL: @scalarize_v2i64_ones_mask(
; CHECK-NEXT:    br i1 true, label [[COND_LOAD:%.*]], label [[ELSE:%.*]]
; CHECK:       cond.load:
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* [[P:%.*]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i64> [[PASSTHRU:%.*]], i64 [[TMP1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, i64* [[P]], i32 1
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[RES_PHI_ELSE:%.*]] = phi <2 x i64> [ [[TMP2]], [[COND_LOAD]] ], [ [[PASSTHRU]], [[TMP0:%.*]] ]
; CHECK-NEXT:    [[PTR_PHI_ELSE:%.*]] = phi i64* [ [[TMP3]], [[COND_LOAD]] ], [ [[P]], [[TMP0]] ]
; CHECK-NEXT:    br i1 true, label [[COND_LOAD1:%.*]], label [[ELSE2:%.*]]
; CHECK:       cond.load1:
; CHECK-NEXT:    [[TMP4:%.*]] = load i64, i64* [[PTR_PHI_ELSE]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x i64> [[RES_PHI_ELSE]], i64 [[TMP4]], i64 1
; CHECK-NEXT:    br label [[ELSE2]]
; CHECK:       else2:
; CHECK-NEXT:    [[RES_PHI_ELSE3:%.*]] = phi <2 x i64> [ [[TMP5]], [[COND_LOAD1]] ], [ [[RES_PHI_ELSE]], [[ELSE]] ]
; CHECK-NEXT:    ret <2 x i64> [[RES_PHI_ELSE3]]
;
  %ret = call <2 x i64> @llvm.masked.expandload.v2i64.p0v2i64(i64* %p, <2 x i1> <i1 true, i1 true>, <2 x i64> %passthru)
  ret <2 x i64> %ret
}

define <2 x i64> @scalarize_v2i64_zero_mask(i64* %p, <2 x i64> %passthru) {
; CHECK-LABEL: @scalarize_v2i64_zero_mask(
; CHECK-NEXT:    br i1 false, label [[COND_LOAD:%.*]], label [[ELSE:%.*]]
; CHECK:       cond.load:
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* [[P:%.*]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i64> [[PASSTHRU:%.*]], i64 [[TMP1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, i64* [[P]], i32 1
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[RES_PHI_ELSE:%.*]] = phi <2 x i64> [ [[TMP2]], [[COND_LOAD]] ], [ [[PASSTHRU]], [[TMP0:%.*]] ]
; CHECK-NEXT:    [[PTR_PHI_ELSE:%.*]] = phi i64* [ [[TMP3]], [[COND_LOAD]] ], [ [[P]], [[TMP0]] ]
; CHECK-NEXT:    br i1 false, label [[COND_LOAD1:%.*]], label [[ELSE2:%.*]]
; CHECK:       cond.load1:
; CHECK-NEXT:    [[TMP4:%.*]] = load i64, i64* [[PTR_PHI_ELSE]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x i64> [[RES_PHI_ELSE]], i64 [[TMP4]], i64 1
; CHECK-NEXT:    br label [[ELSE2]]
; CHECK:       else2:
; CHECK-NEXT:    [[RES_PHI_ELSE3:%.*]] = phi <2 x i64> [ [[TMP5]], [[COND_LOAD1]] ], [ [[RES_PHI_ELSE]], [[ELSE]] ]
; CHECK-NEXT:    ret <2 x i64> [[RES_PHI_ELSE3]]
;
  %ret = call <2 x i64> @llvm.masked.expandload.v2i64.p0v2i64(i64* %p, <2 x i1> <i1 false, i1 false>, <2 x i64> %passthru)
  ret <2 x i64> %ret
}

define <2 x i64> @scalarize_v2i64_const_mask(i64* %p, <2 x i64> %passthru) {
; CHECK-LABEL: @scalarize_v2i64_const_mask(
; CHECK-NEXT:    br i1 false, label [[COND_LOAD:%.*]], label [[ELSE:%.*]]
; CHECK:       cond.load:
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* [[P:%.*]], align 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i64> [[PASSTHRU:%.*]], i64 [[TMP1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, i64* [[P]], i32 1
; CHECK-NEXT:    br label [[ELSE]]
; CHECK:       else:
; CHECK-NEXT:    [[RES_PHI_ELSE:%.*]] = phi <2 x i64> [ [[TMP2]], [[COND_LOAD]] ], [ [[PASSTHRU]], [[TMP0:%.*]] ]
; CHECK-NEXT:    [[PTR_PHI_ELSE:%.*]] = phi i64* [ [[TMP3]], [[COND_LOAD]] ], [ [[P]], [[TMP0]] ]
; CHECK-NEXT:    br i1 true, label [[COND_LOAD1:%.*]], label [[ELSE2:%.*]]
; CHECK:       cond.load1:
; CHECK-NEXT:    [[TMP4:%.*]] = load i64, i64* [[PTR_PHI_ELSE]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x i64> [[RES_PHI_ELSE]], i64 [[TMP4]], i64 1
; CHECK-NEXT:    br label [[ELSE2]]
; CHECK:       else2:
; CHECK-NEXT:    [[RES_PHI_ELSE3:%.*]] = phi <2 x i64> [ [[TMP5]], [[COND_LOAD1]] ], [ [[RES_PHI_ELSE]], [[ELSE]] ]
; CHECK-NEXT:    ret <2 x i64> [[RES_PHI_ELSE3]]
;
  %ret = call <2 x i64> @llvm.masked.expandload.v2i64.p0v2i64(i64* %p, <2 x i1> <i1 false, i1 true>, <2 x i64> %passthru)
  ret <2 x i64> %ret
}

declare <2 x i64> @llvm.masked.expandload.v2i64.p0v2i64(i64*,  <2 x i1>, <2 x i64>)