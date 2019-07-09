import time


def timing(f):
	# Decorator for debug purposes
	# Copied from https://stackoverflow.com/a/5478448
	def wrap(*args):
		time1 = time.time()
		ret = f(*args)
		time2 = time.time()
		print('{:s} function took {:.3f} ms'.format(f.__name__, (time2-time1)*1000.0))

		return ret
	return wrap
