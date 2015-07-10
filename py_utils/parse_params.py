#!/usr/bin/python2.7
# -*- coding: koi8-r -*-

import sys
import os.path
import ConfigParser
import argparse
import itertools

import collections

class iniParser( ConfigParser.ConfigParser ):
  def to_odict( self ):
    d = collections.OrderedDict( self._sections )
    for k in d:
      d[k] = collections.OrderedDict( self._defaults, **d[k] )
      d[k].pop( '__name__', None )
    return d

# �������� ��� ������ ����������������� �����.
# TODO: �������� ��������� ������ ����� ������
def read_config( config_file, default_params_d ):
  try:
    # �������� ���� ��������� ��������� �� ������, ���� �� �� ����� � �������.
    config = ConfigParser.SafeConfigParser( defaults = default_params_d )
    config.read( config_file )
    
    sections = config.sections( )

    params_d = dict( )

    # XXX: ������ ��� ��������� ���������� � ���� �������.
    # ���� � ������ ������� ������ ��������� � ����������� �������, 
    # �� ��������� ������ ���� ����� ��������. 
    for s in sections:
      params_d = dict( params_d.items( ) + config.items( s, raw = True ) )

  except ConfigParser.Error, err:
    print >>sys.stderr, 'Could not parse:', config_file, err
    params_d = None

  return params_d


# ������� ��� ������ � ���������������� ���� ���������.
def write_value_to_config( config_file, section, key, value ):
  value = str( value )

  try:
    config = ConfigParser.SafeConfigParser( ) 

    config.read( config_file )

    config.set( section, key, value )

    with open( config_file, 'wb' ) as f:
      config.write( f )
  
  except ConfigParser.Error, err:
    print >>sys.stderr, 'Could not parse:', config_file, err
  
  except TypeError, err:
    print >>sys.stderr, 'Could not write value to file "' + config_file + '":', err


# ������������� ���������� �������
def config_stream_cnt( config, stream_cnt ):
  write_value_to_config( config, 'general', 'streams', stream_cnt )

# ������� ��� ������ ������� �����
def config_size( config, size ):
  write_value_to_config( config, 'stream', 'frame-size', size )

# ������� ��� ������ ��������
def config_rate( config, rate ):
  write_value_to_config( config, 'stream', 'rate', rate )

# ������� ��� ������ flow id
def config_flow_id( config, flow_id ):
  write_value_to_config( config, 'general', 'flow-id', flow_id )

# ������� ��� ������ ������ ������, ������� ����� �����������������.
def config_stream_idx( config, idx ):
  write_value_to_config( config, 'general', 'stream', idx )



# �������, ������� ������ ���������( ����� ������ ����� ) ��������� ��������� ������
# TODO: ��� ��� ����� ������� ���������� ( � ������ ������� ������� ���������� � �������� ).
def parse_cmd_params( parent_parser, default_params_d, possible_cmd_params_d, argv_l, usage ):
  
  # "�����������" ������ ������� ����������.
  # ������ �� ����� ��������� � help � ��������� ���������.
  parser = argparse.ArgumentParser(
      parents         = [parent_parser],
      description     = usage,
      #formatter_class = argparse.RawDescriptionHelpFormatter,
  )

  # �������� �������� �� ���������.
  # �� ������� ������ ��� ��������� ���������, ������� ���� � �������
  # � �����-����� ��������� ������� ��������� default_params_d.
  if default_params_d:
    parser.set_defaults( **default_params_d )


  cmd_params_keys_l = ( 'short_key', 'long_key', 'dest', 'metavar', 'action', 'help' )

  # ��������� ���� ����������� ��� ���������.
  possible_cmd_params_l = [ dict( zip( cmd_params_keys_l, v ) ) for v in possible_cmd_params_d.values( ) ]


  # TODO: ���������� �� ���������.
  for param in possible_cmd_params_l:
    if param[ 'action' ] == 'store_true':
      parser.add_argument( param[ 'short_key' ], param[ 'long_key' ],
                           dest    = param[ 'dest'    ],
                           action  = param[ 'action'  ],
                           help    = param[ 'help'    ] )
    else:
      parser.add_argument( param[ 'short_key' ], param[ 'long_key' ],
                           dest    = param[ 'dest'    ],
                           metavar = param[ 'metavar' ],
                           help    = param[ 'help'    ] )

  params_d = vars( parser.parse_args( argv_l ) ) 
  
  return params_d



# ������� ��� �������� ���������� ��������� ������ � ����������������� �����.
# ��� ��� ��������� ��������� ������ ����� ������� ���������, 
# �� ������� �� ������ ���������� ������ � ����� ������ ����������, 
# a ��� ����� ������������� �� �� ��, ������� �������� ��� ���������.
def parse_all_params( default_params_d, possible_cmd_params_d, argv_l, usage, params_callback_d = None ):
  
  # ��������� help, ����� ��� ����� -h �� ������ ������ ���������,
  # ������� �� ������ �� ������ ������ ( �.� ������ config )
  parser = argparse.ArgumentParser(
    add_help=False
  )

  # ������ ��� ���������� ������ ���������������� ����
  #parser.add_argument("-c", "--config",
  #                     type    = str,
  #                     metavar = "FILE",
  #                     help = "NOT WORKING OPTION" )


  # ������ �������� �������, ��������� ��������� �� ������� 
  # � ��������� �� ����� � remaining_argv_l
  args, remaining_argv_l = parser.parse_known_args( argv_l )


  # ���� ��� �������� ������, �� ������ ���
  # ��� ���� ��������� ������� ����� ������� ���������, ��� ���������
  # TODO: ����� ���� ����� ����� ��������� ������.
  #if args.config:
  #  conf_params_d = read_config( args.config, default_params_d )

    # ���� �� �� ������ ���������� ������ - ����� ���������� ���������
  #  if conf_params_d: 
  #    default_params_d = conf_params_d
  #  else:  
  #    print >>sys.stderr, "Config parsing error! Use default parameters"
   

  # ������ ��������� ���������
  params_d = parse_cmd_params( parser, default_params_d, possible_cmd_params_d, remaining_argv_l, usage )

  if params_callback_d:
    for param in params_d.keys( ):
      if param in params_callback_d.keys( ): 
        cb = params_callback_d[ param ]
        if cb != None:
          params_d[ param ] = cb( params_d[ param ] )

  # ��������� �������� "config" �� ������, ���� �� ��� ��� �����������.
  params_d.update( vars( args ) )

  return params_d


# \brief     Parse integer set.
#
# \range_str String with integers and ranges.
#            Example: 
#              "0 1, 2-4, 7, 0xA - 12    13, 0x20 - 28"
#
# \return    List with parsed integers
#            Example:
#              [0, 1, 2, 3, 4, 7, 10, 11, 12, 13, 28, 29, 30, 31, 32]
def parse_range( range_str ):
  # Process empty string
  if not range_str:
    return []

  res = set()

  range_l = [ i.strip( ) for i in range_str.split( '-' ) ]
  range_str = '-'.join( range_l )
  range_l = range_str.replace( ',', ' ' ).split( );

  for x in range_l:
    xr = x.split('-')

    try:
      max_xr = max( int( xr[0], 0 ), int( xr[-1], 0 ) )
      min_xr = min( int( xr[0], 0 ), int( xr[-1], 0 ) )
    except ValueError:
      print >>sys.stderr, 'Error: parse_range, unknown range type: "%s"' % x
      sys.exit( -1 )
    
    res.update( range( min_xr, max_xr + 1 ) )
  
  return sorted( res )


# \brief Parse ini file
#
# \param file_s Path to file
#
# \return Dictionary with settings
def parse_ini( file_s ):

  if os.path.isfile( file_s ) == False:
    print "File \'%s\' doesn't exist or it isn't file" % ( file_s )
    sys.exit( -1 )

  try:
    config = iniParser()
    config.read( file_s )
    settings_od = config.to_odict()

  except ConfigParser.Error, err:
    print >>sys.stderr, 'Error: reading from file %s (%s)' % ( file_s, err )
    sys.exit( -1 )

  return settings_od


# \brief  Read configure file with settings.
#
# \param  params_d Dict with parameters
#
# \return Dict with settings
def read_settings_file( params_d ):

  if not params_d[ 'settings-file' ]:
    print >>sys.stderr, 'Error: You must set settings file'
    sys.exit( -1 )

  return parse_ini( params_d[ 'settings-file' ] )

# \brief Form iterator object contains ranges from sorted list
#
# \param sorted_list Input sorted list
#
# \return Iterator object contains ranges
def ranges( sorted_list ):
  for a, b in itertools.groupby(enumerate(sorted_list), lambda (x, y): y - x):
    b = list(b)
    yield b[0][1], b[-1][1]

# \brief Form list of ranges from sorted list
#
# \param sorted_list Input sorted list
#
# \return List of ranges (each range is tuple "(start_num, end_num)" )
#         It is possible tuple, for example, "( 10, 10 )"
def sorted_list2ranges_list( sorted_list ):
  return list( ranges( sorted_list ) )

if __name__ == "__main__":
  import optparse

  parser = optparse.OptionParser( )
  parser.add_option( '-n', dest = 'n' )

  opt,args = parser.parse_args( )

  int_l = parse_range( opt.n )
  print int_l
