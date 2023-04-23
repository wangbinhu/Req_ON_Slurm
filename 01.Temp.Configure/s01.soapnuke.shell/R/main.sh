####################################  main.sh  ###################################

source /ifswh1/BC_PUB/biosoft/BC_NQ/01.Soft/03.Soft_ALL/environment.sh

Main_WK_DIR=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SINrzsnR     # fix  
Step02_IN_PATH=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SINrzsnR/01.raw.data    # fix 
Step02_OUT_PATH=/ifswh1/BC_COM_P4/F21FTSSCKF9402/SINrzsnR/02.process/01.clean.data.l07.q03.n01   # fix

# step 00:
SC_DIR=/home/wangbinhu/01.Piepe.Line/01.raw.data.filter.and.summary
mkdir -p $Main_WK_DIR/01.raw.data
mkdir -p $Main_WK_DIR/02.process
# mkdir -p $Main_WK_DIR/03.result

# step 01:
/ifswh1/BC_PUB/biosoft/BC_NQ/01.Soft/03.Soft_ALL/Python-3.6.2/python    $SC_DIR/s01.step01.ln.cat.py >  $SC_DIR/step01.ln.cat.sh
cp    $SC_DIR/step01.ln.cat.sh  $Main_WK_DIR/01.raw.data

# step 02:
mkdir -p $Main_WK_DIR/02.process/l01.log
cp $SC_DIR/s02.soapnuke.fliter.py  $Main_WK_DIR/02.process
cp $SC_DIR/config.py  $Main_WK_DIR/02.process

####################################  main.sh  ###################################
