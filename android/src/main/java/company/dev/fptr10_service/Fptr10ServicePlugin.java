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

    statusEventChannel.setStreamHandler(new StatusEventHandler(applicationContext, fptr));
    methodChannel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    switch (call.method) {

      case "validateJson":
        fptr.setParam(IFptr.LIBFPTR_PARAM_JSON_DATA, call.argument("task").toString());
        fptr.validateJson();
        break;
      case "performJson":
        fptr.setParam(IFptr.LIBFPTR_PARAM_JSON_DATA, call.argument("task").toString());
        fptr.processJson();
        result.success(fptr.getParamString(IFptr.LIBFPTR_PARAM_JSON_DATA));
        break;
      case "setSettings":
        String settings = String.format("{\"%s\": %d, \"%s\": %d, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %d}",
        IFptr.LIBFPTR_SETTING_MODEL, IFptr.LIBFPTR_MODEL_ATOL_AUTO,
        IFptr.LIBFPTR_SETTING_PORT, IFptr.LIBFPTR_PORT_TCPIP,
        IFptr.LIBFPTR_SETTING_COM_FILE, "COM5",
        IFptr.LIBFPTR_SETTING_IPADDRESS, call.argument("tcp_ip_address"),
        IFptr.LIBFPTR_SETTING_IPPORT, 5555);
        fptr.setSettings(settings);
        break;
      case "getSettings":
        result.success(fptr.getSettings());
        break;
      case "getDriverVersion":
        result.success(fptr.version());
        break;
      case "isOpened":
        result.success(fptr.isOpened());
        break;
      case "open":
        fptr.open();
        result.success(fptr.isOpened());
        break;
      case "close":
        fptr.close();
        result.success(!fptr.isOpened());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    applicationContext = null;
    methodChannel.setMethodCallHandler(null);
    methodChannel = null;
    statusEventChannel.setStreamHandler(null);
    statusEventChannel = null;
    fptr.destroy();
  }

}
