package company.dev.fptr10_service;

import android.content.Context;
import android.os.Handler;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** ATOL libs */
import ru.atol.drivers10.fptr.Fptr;
import ru.atol.drivers10.fptr.IFptr;


/** Fptr10ServicePlugin */
public class Fptr10ServicePlugin implements  MethodCallHandler, FlutterPlugin {
  private Context applicationContext;
  private IFptr fptr;
  private MethodChannel methodChannel;
  private EventChannel statusEventChannel;


  @SuppressWarnings("deprecation")
  public static void registerWith(PluginRegistry.Registrar registrar) {
    final Fptr10ServicePlugin instance = new Fptr10ServicePlugin();
    instance.onAttachedToEngine(registrar.context(), registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
    this.applicationContext = applicationContext;
    this.fptr = new Fptr(applicationContext);
    methodChannel = new MethodChannel(messenger, "company.dev/fptr10_service");
    statusEventChannel = new EventChannel(messenger, "company.dev/fptr10_events/status");

    // statusEventChannel.setStreamHandler(new StatusEventHandler(applicationContext, fptr, 3000));
    methodChannel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    switch (call.method) {
      case "getDriverVersion":
        onGetDriverVersion(call, result);
        break;
      case "getSettings":
        onGetSettings(call, result);
        break;
      case "getStatus":
        onGetStatus(call, result);
        break;
      case "performJson":
        onPerformJson(call, result);
        break;
      case "setSettings":
        onSetSettings(call, result);
        break;
      case "validateJson":
        onValidateJson(call, result);
        break;
      case "isOpened":
        result.success(fptr.isOpened());
        break;
      case "open":
        onOpen(call, result);
        break;
      case "close":
        onClose(call, result);
        break;
      case "openSell":
        openSell(call, result);
        break;
      case "cancelSell":
        cancelSell(call, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }


  private void openSell(MethodCall call, Result result){
    boolean isRefund = Boolean.parseBoolean(call.argument("isRefund")); 
    boolean electronically = Boolean.parseBoolean(call.argument("electronically"));
    fptr.setParam(IFptr.LIBFPTR_PARAM_RECEIPT_TYPE, isRefund ? IFptr.LIBFPTR_RT_SELL_RETURN : IFptr.LIBFPTR_RT_SELL);
    fptr.setParam(IFptr.LIBFPTR_PARAM_RECEIPT_ELECTRONICALLY, electronically);
    fptr.openReceipt();
    result.success(true);
  }

  private void cancelSell(MethodCall call, Result result){
    fptr.cancelReceipt();
    result.success(true);
  }

  private  void onValidateJson(MethodCall call, Result result) {
    fptr.setParam(IFptr.LIBFPTR_PARAM_JSON_DATA, call.argument("task").toString());

    int responseCode = fptr.validateJson();
    if (responseCode != 0) {
      result.error(String.format("%s",responseCode), fptr.errorDescription(), null);
    } else {
      result.success(true);
    }
  }

  private void onGetSettings(MethodCall call, Result result) {
    String settings = fptr.getSettings();
    if (settings == null) {
      result.error("SETTINGS_GET_ERROR", fptr.errorDescription(), null);
      return;
    }

    result.success(settings);
  }


  private void onSetSettings(MethodCall call, Result result) {
    int model = IFptr.LIBFPTR_MODEL_ATOL_AUTO;
    int port = IFptr.LIBFPTR_PORT_TCPIP;
    String comFile = "COM5";
    String tcpIpAddress = call.argument("tcp_ip_address");
    int tcpIpPort = call.argument("tcp_ip_port");

    String settings = String.format(
      "{\"%s\": %d, \"%s\": %d, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %d}",
      IFptr.LIBFPTR_SETTING_MODEL, model,
      IFptr.LIBFPTR_SETTING_PORT, port,
      IFptr.LIBFPTR_SETTING_COM_FILE, comFile,
      IFptr.LIBFPTR_SETTING_IPADDRESS, tcpIpAddress,
      IFptr.LIBFPTR_SETTING_IPPORT, tcpIpPort
    );

    int responseCode = fptr.setSettings(settings);
    if (responseCode != 0) {
      result.error(String.valueOf(responseCode), fptr.errorDescription(), null);
    } else {
      result.success(true);
    }
  }

  private void onPerformJson(MethodCall call, Result result) {
    try {
      Map<String, String> arguments = call.arguments(); 
      String taskJson = arguments.get("task");

      fptr.setParam(IFptr.LIBFPTR_PARAM_JSON_DATA, taskJson);
      int responseCode = fptr.processJson();
      
      if (responseCode != 0) {
        result.error(String.valueOf(responseCode), fptr.errorDescription(), null);
      } else {
        String jsonData = fptr.getParamString(IFptr.LIBFPTR_PARAM_JSON_DATA);
        result.success(jsonData);
      }
    } catch (Exception e) {
      result.error("JSON_PERFORM_ERROR", e.getMessage(), null);
    }
  }

  private  void onGetDriverVersion(MethodCall call, Result result){
    String version = fptr.version();

    if(version != null){
      result.success(version);
    } else {
      result.error("VERSION_GET_ERROR", fptr.errorDescription(), null);
    }
  }

  private  void onClose(MethodCall call, Result result){
    int responseCode = fptr.close();
    if(responseCode == 0){
      result.success(true);
    } else {
      result.error(String.format("%s",responseCode), fptr.errorDescription(),null);
    }
  }

  private  void onOpen(MethodCall call, Result result){
    int responseCode = fptr.open();
    if(responseCode == 0){
      result.success(true);
    } else {
      result.error(String.format("%s",responseCode), fptr.errorDescription(), null);
    }
  }


  private void onGetStatus(MethodCall call, Result result) {
    Map<String, Object> status = new HashMap<>();

    try {
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

    } catch (Exception e) {
      result.error("STATUS_ERROR", fptr.errorDescription(), null);
    }

    result.success(status);
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    applicationContext = null;
    methodChannel.setMethodCallHandler(null);
    methodChannel = null;
    // statusEventChannel.setStreamHandler(null);
    statusEventChannel = null;
    fptr.destroy();
  }

}
