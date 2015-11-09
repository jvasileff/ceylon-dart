import com.redhat.ceylon.common {
    Backend
}

shared Backend dartBackend
    =   Backend.registerBackend("Dart", "dart");