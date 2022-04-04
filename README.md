Was trying to understand why StreamController<int>.broadcast() wasn't working for me.

I found that the _BroadcastStream from asBroadcastStream() did work perfectly.