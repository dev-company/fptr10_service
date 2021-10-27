package company.dev.fptr10_service;

import android.content.Context;
import android.os.Handler;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import ru.atol.drivers10.fptr.IFptr;

public class StatusEventHandler implements EventChannel.StreamHandler{

    final private IFptr fptr;
    private final Handler handler = new Handler();
    EventChannel.EventSink eventSink;


    public StatusEventHandler(Context context, IFptr fptr) {
        this.fptr=fptr;
    }


    private final Runnable runnable = new Runnable() {
        @Override
        public void run() {
            eventSink.success(fptrStatusMap());
            handler.postDelayed(this, 1000);
        }
    };



    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        System.out.println("StreamHandler - onListen: " + o);
        this.eventSink = eventSink;
        runnable.run();
    }

    @Override
    public void onCancel(Object o) {
        System.out.println("StreamHandler - onCancel: " + o);
        handler.removeCallbacks(runnable);
    }



    private Map<String, Object> fptrStatusMap(){
        Map<String, Object>  status = new HashMap<>();

        fptr.setParam(IFptr.LIBFPTR_PARAM_DATA_TYPE, IFptr.LIBFPTR_DT_STATUS);
        fptr.queryData();

        long operatorID      = fptr.getParamInt(IFptr.LIBFPTR_PARAM_OPERATOR_ID);
        long logicalNumber   = fptr.getParamInt(IFptr.LIBFPTR_PARAM_LOGICAL_NUMBER);
        long shiftState      = fptr.getParamInt(IFptr.LIBFPTR_PARAM_SHIFT_STATE);

        String modelName     = fptr.getParamString(IFptr.LIBFPTR_PARAM_MODEL_NAME);
        long mode            = fptr.getParamInt(IFptr.LIBFPTR_PARAM_MODE);
        long submode         = fptr.getParamInt(IFptr.LIBFPTR_PARAM_SUBMODE);
        long receiptNumber   = fptr.getParamInt(IFptr.LIBFPTR_PARAM_RECEIPT_NUMBER);
        long documentNumber  = fptr.getParamInt(IFptr.LIBFPTR_PARAM_DOCUMENT_NUMBER);
        long shiftNumber     = fptr.getParamInt(IFptr.LIBFPTR_PARAM_SHIFT_NUMBER);
        long receiptType     = fptr.getParamInt(IFptr.LIBFPTR_PARAM_RECEIPT_TYPE);
        long documentType    = fptr.getParamInt(IFptr.LIBFPTR_PARAM_DOCUMENT_TYPE);
        long lineLength      = fptr.getParamInt(IFptr.LIBFPTR_PARAM_RECEIPT_LINE_LENGTH);
        long lineLengthPix   = fptr.getParamInt(IFptr.LIBFPTR_PARAM_RECEIPT_LINE_LENGTH_PIX);

        double receiptSum = fptr.getParamDouble(IFptr.LIBFPTR_PARAM_RECEIPT_SUM);

        boolean isFiscalDevice          = fptr.getParamBool(IFptr.LIBFPTR_PARAM_FISCAL);
        boolean isFiscalFN              = fptr.getParamBool(IFptr.LIBFPTR_PARAM_FN_FISCAL);
        boolean isFNPresent             = fptr.getParamBool(IFptr.LIBFPTR_PARAM_FN_PRESENT);
        boolean isInvalidFN             = fptr.getParamBool(IFptr.LIBFPTR_PARAM_INVALID_FN);
        boolean isCashDrawerOpened      = fptr.getParamBool(IFptr.LIBFPTR_PARAM_CASHDRAWER_OPENED);
        boolean isPaperPresent          = fptr.getParamBool(IFptr.LIBFPTR_PARAM_RECEIPT_PAPER_PRESENT);
        boolean isPaperNearEnd          = fptr.getParamBool(IFptr.LIBFPTR_PARAM_PAPER_NEAR_END);
        boolean isCoverOpened           = fptr.getParamBool(IFptr.LIBFPTR_PARAM_COVER_OPENED);
        boolean isPrinterConnectionLost = fptr.getParamBool(IFptr.LIBFPTR_PARAM_PRINTER_CONNECTION_LOST);
        boolean isPrinterError          = fptr.getParamBool(IFptr.LIBFPTR_PARAM_PRINTER_ERROR);
        boolean isCutError              = fptr.getParamBool(IFptr.LIBFPTR_PARAM_CUT_ERROR);
        boolean isPrinterOverheat       = fptr.getParamBool(IFptr.LIBFPTR_PARAM_PRINTER_OVERHEAT);
        boolean isDeviceBlocked         = fptr.getParamBool(IFptr.LIBFPTR_PARAM_BLOCKED);

        fptr.setParam(IFptr.LIBFPTR_PARAM_DATA_TYPE, IFptr.LIBFPTR_DT_SHIFT_STATE);
        fptr.queryData();


        status.put("operatorID", operatorID);
        status.put("logicalNumber", logicalNumber);
        status.put("shiftState", shiftState);
        status.put("modelName", modelName);
        status.put("mode", mode);
        status.put("submode", submode);
        status.put("receiptNumber", receiptNumber);
        status.put("documentNumber", documentNumber);
        status.put("shiftNumber", shiftNumber);

        status.put("receiptType", receiptType);
        status.put("documentType", documentType);
        status.put("lineLength", lineLength);
        status.put("lineLengthPix", lineLengthPix);
        status.put("receiptSum", receiptSum);
        status.put("isFiscalDevice", isFiscalDevice);
        status.put("isFiscalFN", isFiscalFN);
        status.put("isFNPresent", isFNPresent);
        status.put("isInvalidFN", isInvalidFN);

        status.put("isCashDrawerOpened", isCashDrawerOpened);
        status.put("isPaperPresent", isPaperPresent);
        status.put("isPaperNearEnd", isPaperNearEnd);
        status.put("isCoverOpened", isCoverOpened);
        status.put("isPrinterConnectionLost", isPrinterConnectionLost);
        status.put("isPrinterError", isPrinterError);
        status.put("isCutError", isCutError);
        status.put("isPrinterOverheat", isPrinterOverheat);
        status.put("isDeviceBlocked", isDeviceBlocked);

        return status;
    }
}
