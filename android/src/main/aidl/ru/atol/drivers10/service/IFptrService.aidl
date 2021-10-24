// IFptrService.aidl
package ru.atol.drivers10.service;

interface IFptrService {
    String processJson(String request);

    String getServiceVersion();
    String getDriverVersion();

    String flashInternalFirmware();
    String getInternalFirmwareConfigurationVersion();
    String getInternalFirmwareVersion();
    String getInternalFirmwareBootloaderVersion();
    String getInternalFirmwareScriptsVersion();

    boolean isInBoot();
    boolean isUpdating();
}
