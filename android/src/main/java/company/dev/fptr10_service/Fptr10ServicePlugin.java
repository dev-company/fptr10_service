package company.dev.fptr10_service;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** ATOL */
import ru.atol.drivers10.fptr.Fptr;
import ru.atol.drivers10.fptr.IFptr;

/** Fptr10ServicePlugin */
public class Fptr10ServicePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private IFptr fptr;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "company.dev/fptr10_service");
    fptr = new Fptr(flutterPluginBinding.getApplicationContext());
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getDriverVersion":
        result.success("ATOL "+fptr.version());
        break;
      case "getSettings":
        result.success("Settings: "+fptr.getSettings());
        break;
      case "setSettings":
        String settings = String.format("{\"%s\": %d, \"%s\": %d, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %d}",
        IFptr.LIBFPTR_SETTING_MODEL, IFptr.LIBFPTR_MODEL_ATOL_AUTO,
        IFptr.LIBFPTR_SETTING_PORT, IFptr.LIBFPTR_PORT_TCPIP,
        IFptr.LIBFPTR_SETTING_COM_FILE, "COM5",
        IFptr.LIBFPTR_SETTING_IPADDRESS, call.argument("tcp_ip_address"),
        IFptr.LIBFPTR_SETTING_IPPORT, call.argument("tcp_ip_port"));
        fptr.setSettings(settings);
        break;
      case "isOpened":
        boolean isOpened = fptr.isOpened();
        result.success(isOpened);
        break;
      case "open":
        fptr.open();
        result.success(true);
        break;
      case "close":
        fptr.close();
        result.success(true);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    fptr.destroy();
    channel.setMethodCallHandler(null);
  }

}
