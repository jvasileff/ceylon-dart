void $package$internal$asyncRun([$ceylon$language.Callable task]) {
    $dart$async.Timer.run(() { task.f(); });
}

void internal$asyncRun([$ceylon$language.Callable task]) => $package$internal$asyncRun(task);

