import functools

from IPython.core.magic import register_line_magic


@register_line_magic
def getutf(string):
    """Get the Unicode index of a character."""
    for char in string:
        print(hex(ord(char)))


def shell(func):
    """Make a line magic to call the named shell command."""
    @functools.wraps(func)
    def wrapper(*args, **kw):
        """Call the named shell command."""
        os.system(f"{func.__name__} {args[0]}")
        return func(*args, **kw)
    return register_line_magic(wrapper)


@shell
def vi(line): pass
@shell
def gcc(line): pass
@shell
def cmake(line): pass
@shell
def make(line): pass
@shell
def git(line): pass
@shell
def sudo(line): pass
@shell
def aria2c(line): pass
@shell
def brew(line): pass


del getutf, vi, gcc, make, cmake, git, sudo, aria2c, brew
