/******************************************************************************
 *
 * Copyright(c) 2007 - 2017 Realtek Corporation.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 *****************************************************************************/
#define _RTW_EFUSE_C_

#include <drv_types.h>
#include <hal_data.h>

#include "../hal/efuse/efuse_mask.h"

/*------------------------Define local variable------------------------------*/
u8	fakeEfuseBank = {0};
u32	fakeEfuseUsedBytes = {0};
u8	fakeEfuseContent[EFUSE_MAX_HW_SIZE] = {0};
u8	fakeEfuseInitMap[EFUSE_MAX_MAP_LEN] = {0};
u8	fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN] = {0};

u32	BTEfuseUsedBytes = {0};
u8	BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
u8	BTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
u8	BTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};

u32	fakeBTEfuseUsedBytes = {0};
u8	fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
u8	fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
u8	fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};

u8	maskfileBuffer[64];
/*------------------------Define local variable------------------------------*/
BOOLEAN rtw_file_efuse_IsMasked(PADAPTER pAdapter, u16 Offset)
{
	int r = Offset / 16;
	int c = (Offset % 16) / 2;
	int result = 0;

	if (pAdapter->registrypriv.boffefusemask)
		return FALSE;

	if (c < 4) /* Upper double word */
		result = (maskfileBuffer[r] & (0x10 << c));
	else
		result = (maskfileBuffer[r] & (0x01 << (c - 4)));

	return (result > 0) ? 0 : 1;
}

BOOLEAN efuse_IsMasked(PADAPTER pAdapter, u16 Offset)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	if (pAdapter->registrypriv.boffefusemask)
		return FALSE;

#if DEV_BUS_TYPE == RT_USB_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return (IS_MASKED(8188E, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		return (IS_MASKED(8812A, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8821A)
#if 0
	if (IS_HARDWARE_TYPE_8811AU(pAdapter))
		return (IS_MASKED(8811A, _MUSB, Offset)) ? TRUE : FALSE;
#endif
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		return (IS_MASKED(8821A, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		return (IS_MASKED(8192E, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		return (IS_MASKED(8723B, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8703B)
	if (IS_HARDWARE_TYPE_8703B(pAdapter))
		return (IS_MASKED(8703B, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		return (IS_MASKED(8814A, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8188F)
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		return (IS_MASKED(8188F, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return (IS_MASKED(8822B, _MUSB, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8723D)
	if (IS_HARDWARE_TYPE_8723D(pAdapter))
		return (IS_MASKED(8723D, _MUSB, Offset)) ? TRUE : FALSE;
#endif

#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CU(pAdapter))
		return (IS_MASKED(8821C, _MUSB, Offset)) ? TRUE : FALSE;
#endif

#elif DEV_BUS_TYPE == RT_PCI_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return (IS_MASKED(8188E, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		return (IS_MASKED(8192E, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		return (IS_MASKED(8812A, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		return (IS_MASKED(8821A, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		return (IS_MASKED(8723B, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		return (IS_MASKED(8814A, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return (IS_MASKED(8822B, _MPCIE, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CE(pAdapter))
		return (IS_MASKED(8821C, _MPCIE, Offset)) ? TRUE : FALSE;
#endif

#elif DEV_BUS_TYPE == RT_SDIO_INTERFACE
#ifdef CONFIG_RTL8188E_SDIO
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return (IS_MASKED(8188E, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#ifdef CONFIG_RTL8723B
	if (IS_HARDWARE_TYPE_8723BS(pAdapter))
		return (IS_MASKED(8723B, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#ifdef CONFIG_RTL8188F_SDIO
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		return (IS_MASKED(8188F, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#ifdef CONFIG_RTL8192E
	if (IS_HARDWARE_TYPE_8192ES(pAdapter))
		return (IS_MASKED(8192E, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821S(pAdapter))
		return (IS_MASKED(8821A, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CS(pAdapter))
		return (IS_MASKED(8821C, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return (IS_MASKED(8822B, _MSDIO, Offset)) ? TRUE : FALSE;
#endif
#endif

	return FALSE;
}

void rtw_efuse_mask_array(PADAPTER pAdapter, u8 *pArray)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

#if DEV_BUS_TYPE == RT_USB_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		GET_MASK_ARRAY(8188E, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		GET_MASK_ARRAY(8812A, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		GET_MASK_ARRAY(8821A, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		GET_MASK_ARRAY(8192E, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		GET_MASK_ARRAY(8723B, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8703B)
	if (IS_HARDWARE_TYPE_8703B(pAdapter))
		GET_MASK_ARRAY(8703B, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8188F)
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		GET_MASK_ARRAY(8188F, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		GET_MASK_ARRAY(8814A, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		GET_MASK_ARRAY(8822B, _MUSB, pArray);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CU(pAdapter))
		GET_MASK_ARRAY(8821C, _MUSB, pArray);
#endif


#elif DEV_BUS_TYPE == RT_PCI_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		GET_MASK_ARRAY(8188E, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		GET_MASK_ARRAY(8192E, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		GET_MASK_ARRAY(8812A, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		GET_MASK_ARRAY(8821A, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		GET_MASK_ARRAY(8723B, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		GET_MASK_ARRAY(8814A, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		GET_MASK_ARRAY(8822B, _MPCIE, pArray);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CE(pAdapter))
		GET_MASK_ARRAY(8821C, _MPCIE, pArray);
#endif


#elif DEV_BUS_TYPE == RT_SDIO_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		GET_MASK_ARRAY(8188E, _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723BS(pAdapter))
		GET_MASK_ARRAY(8723B, _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8188F)
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		GET_MASK_ARRAY(8188F, _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192ES(pAdapter))
		GET_MASK_ARRAY(8192E, _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821S(pAdapter))
		GET_MASK_ARRAY(8821A, _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CS(pAdapter))
		GET_MASK_ARRAY(8821C , _MSDIO, pArray);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		GET_MASK_ARRAY(8822B , _MSDIO, pArray);
#endif
#endif /*#elif DEV_BUS_TYPE == RT_SDIO_INTERFACE*/
}

u16 rtw_get_efuse_mask_arraylen(PADAPTER pAdapter)
{
	HAL_DATA_TYPE	*pHalData = GET_HAL_DATA(pAdapter);

#if DEV_BUS_TYPE == RT_USB_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return GET_MASK_ARRAY_LEN(8188E, _MUSB);
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		return GET_MASK_ARRAY_LEN(8812A, _MUSB);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		return GET_MASK_ARRAY_LEN(8821A, _MUSB);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		return GET_MASK_ARRAY_LEN(8192E, _MUSB);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		return GET_MASK_ARRAY_LEN(8723B, _MUSB);
#endif
#if defined(CONFIG_RTL8703B)
	if (IS_HARDWARE_TYPE_8703B(pAdapter))
		return GET_MASK_ARRAY_LEN(8703B, _MUSB);
#endif
#if defined(CONFIG_RTL8188F)
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		return GET_MASK_ARRAY_LEN(8188F, _MUSB);
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		return GET_MASK_ARRAY_LEN(8814A, _MUSB);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return GET_MASK_ARRAY_LEN(8822B, _MUSB);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CU(pAdapter))
		return GET_MASK_ARRAY_LEN(8821C, _MUSB);
#endif


#elif DEV_BUS_TYPE == RT_PCI_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return GET_MASK_ARRAY_LEN(8188E, _MPCIE);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192E(pAdapter))
		return GET_MASK_ARRAY_LEN(8192E, _MPCIE);
#endif
#if defined(CONFIG_RTL8812A)
	if (IS_HARDWARE_TYPE_8812(pAdapter))
		return GET_MASK_ARRAY_LEN(8812A, _MPCIE);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821(pAdapter))
		return GET_MASK_ARRAY_LEN(8821A, _MPCIE);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723B(pAdapter))
		return GET_MASK_ARRAY_LEN(8723B, _MPCIE);
#endif
#if defined(CONFIG_RTL8814A)
	if (IS_HARDWARE_TYPE_8814A(pAdapter))
		return GET_MASK_ARRAY_LEN(8814A, _MPCIE);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return GET_MASK_ARRAY_LEN(8822B, _MPCIE);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CE(pAdapter))
		return GET_MASK_ARRAY_LEN(8821C, _MPCIE);
#endif


#elif DEV_BUS_TYPE == RT_SDIO_INTERFACE
#if defined(CONFIG_RTL8188E)
	if (IS_HARDWARE_TYPE_8188E(pAdapter))
		return GET_MASK_ARRAY_LEN(8188E, _MSDIO);
#endif
#if defined(CONFIG_RTL8723B)
	if (IS_HARDWARE_TYPE_8723BS(pAdapter))
		return GET_MASK_ARRAY_LEN(8723B, _MSDIO);
#endif
#if defined(CONFIG_RTL8188F)
	if (IS_HARDWARE_TYPE_8188F(pAdapter))
		return GET_MASK_ARRAY_LEN(8188F, _MSDIO);
#endif
#if defined(CONFIG_RTL8192E)
	if (IS_HARDWARE_TYPE_8192ES(pAdapter))
		return GET_MASK_ARRAY_LEN(8192E, _MSDIO);
#endif
#if defined(CONFIG_RTL8821A)
	if (IS_HARDWARE_TYPE_8821S(pAdapter))
		return GET_MASK_ARRAY_LEN(8821A, _MSDIO);
#endif
#if defined(CONFIG_RTL8821C)
	if (IS_HARDWARE_TYPE_8821CS(pAdapter))
		return GET_MASK_ARRAY_LEN(8821C, _MSDIO);
#endif
#if defined(CONFIG_RTL8822B)
	if (IS_HARDWARE_TYPE_8822B(pAdapter))
		return GET_MASK_ARRAY_LEN(8822B, _MSDIO);
#endif
#endif
	return 0;
}

static void rtw_mask_map_read(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
	u16 i = 0;

	if (padapter->registrypriv.boffefusemask == 0) {

			for (i = 0; i < cnts; i++) {
				if (padapter->registrypriv.bFileMaskEfuse == _TRUE) {
					if (rtw_file_efuse_IsMasked(padapter, addr + i)) /*use file efuse mask.*/
						data[i] = 0xff;
				} else {
					/*RTW_INFO(" %s , data[%d] = %x\n", __func__, i, data[i]);*/
					if (efuse_IsMasked(padapter, addr + i)) {
						data[i] = 0xff;
						/*RTW_INFO(" %s ,mask data[%d] = %x\n", __func__, i, data[i]);*/
					}
				}
			}

	}
}

u8 rtw_efuse_mask_map_read(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
	u8	ret = _SUCCESS;
	u16	mapLen = 0;

	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, _FALSE);

	ret = rtw_efuse_map_read(padapter, addr, cnts , data);

	rtw_mask_map_read(padapter, addr, cnts , data);

	return ret;

}

/* ***********************************************************
 *				Efuse related code
 * *********************************************************** */
static u8 hal_EfuseSwitchToBank(
	PADAPTER	padapter,
	u8			bank,
	u8			bPseudoTest)
{
	u8 bRet = _FALSE;
	u32 value32 = 0;
#ifdef HAL_EFUSE_MEMORY
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(padapter);
	PEFUSE_HAL pEfuseHal = &pHalData->EfuseHal;
#endif


	RTW_INFO("%s: Efuse switch bank to %d\n", __FUNCTION__, bank);
	if (bPseudoTest) {
#ifdef HAL_EFUSE_MEMORY
		pEfuseHal->fakeEfuseBank = bank;
#else
		fakeEfuseBank = bank;
#endif
		bRet = _TRUE;
	} else {
		value32 = rtw_read32(padapter, 0x34);
		bRet = _TRUE;
		switch (bank) {
		case 0:
			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
			break;
		case 1:
			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_0);
			break;
		case 2:
			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_1);
			break;
		case 3:
			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_BT_SEL_2);
			break;
		default:
			value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
			bRet = _FALSE;
			break;
		}
		rtw_write32(padapter, 0x34, value32);
	}

	return bRet;
}

void rtw_efuse_analyze(PADAPTER	padapter, u8 Type, u8 Fake)
{
	HAL_DATA_TYPE	*pHalData = GET_HAL_DATA(padapter);
	PEFUSE_HAL		pEfuseHal = &(pHalData->EfuseHal);
	u16	eFuse_Addr = 0;
	u8 offset, wden;
	u16	 i, j;
	u8	u1temp = 0;
	u8	efuseHeader = 0, efuseExtHdr = 0, efuseData[EFUSE_MAX_WORD_UNIT*2] = {0}, dataCnt = 0;
	u16	efuseHeader2Byte = 0;
	u8	*eFuseWord = NULL;// [EFUSE_MAX_SECTION_NUM][EFUSE_MAX_WORD_UNIT];
	u8	offset_2_0 = 0;
	u8	pgSectionCnt = 0;
	u8	wd_cnt = 0;
	u8	max_section = 64;
	u16	mapLen = 0, maprawlen = 0;
	boolean	bExtHeader = _FALSE;
	u8	efuseType = EFUSE_WIFI;
	boolean	bPseudoTest = _FALSE;
	u8	bank = 0, startBank = 0, endBank = 1-1;
	boolean	bCheckNextBank = FALSE;
	u8	protectBytesBank = 0;
	u16	efuse_max = 0;
	u8	ParseEfuseExtHdr, ParseEfuseHeader, ParseOffset, ParseWDEN, ParseOffset2_0;

	eFuseWord = rtw_zmalloc(EFUSE_MAX_SECTION_NUM * (EFUSE_MAX_WORD_UNIT * 2));

	RTW_INFO("\n");
	if (Type == 0) {
		if (Fake == 0) {
			RTW_INFO("\n\tEFUSE_Analyze Wifi Content\n");
			efuseType = EFUSE_WIFI;
			bPseudoTest = FALSE;
			startBank = 0;
			endBank = 0;
		} else {
			RTW_INFO("\n\tEFUSE_Analyze Wifi Pseudo Content\n");
			efuseType = EFUSE_WIFI;
			bPseudoTest = TRUE;
			startBank = 0;
			endBank = 0;
		}
	} else {
		if (Fake == 0) {
			RTW_INFO("\n\tEFUSE_Analyze BT Content\n");
			efuseType = EFUSE_BT;
			bPseudoTest = FALSE;
			startBank = 1;
			endBank = EFUSE_MAX_BANK - 1;
		} else {
			RTW_INFO("\n\tEFUSE_Analyze BT Pseudo Content\n");
			efuseType = EFUSE_BT;
			bPseudoTest = TRUE;
			startBank = 1;
			endBank = EFUSE_MAX_BANK - 1;
			if (IS_HARDWARE_TYPE_8821(padapter))
				endBank = 3 - 1;/*EFUSE_MAX_BANK_8821A - 1;*/
		}
	}

	RTW_INFO("\n\r 1Byte header, [7:4]=offset, [3:0]=word enable\n");
	RTW_INFO("\n\r 2Byte header, header[7:5]=offset[2:0], header[4:0]=0x0F\n");
	RTW_INFO("\n\r 2Byte header, extHeader[7:4]=offset[6:3], extHeader[3:0]=word enable\n");

	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, bPseudoTest);
	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAX_SECTION, (PVOID)&max_section, bPseudoTest);
	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_PROTECT_BYTES_BANK, (PVOID)&protectBytesBank, bPseudoTest);
	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_CONTENT_LEN_BANK, (PVOID)&efuse_max, bPseudoTest);
	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (PVOID)&maprawlen, _FALSE);

	_rtw_memset(eFuseWord, 0xff, EFUSE_MAX_SECTION_NUM * (EFUSE_MAX_WORD_UNIT * 2));
	_rtw_memset(pEfuseHal->fakeEfuseInitMap, 0xff, EFUSE_MAX_MAP_LEN);

	if (IS_HARDWARE_TYPE_8821(padapter))
		endBank = 3 - 1;/*EFUSE_MAX_BANK_8821A - 1;*/

	for (bank = startBank; bank <= endBank; bank++) {
		if (!hal_EfuseSwitchToBank(padapter, bank, bPseudoTest)) {
			RTW_INFO("EFUSE_SwitchToBank() Fail!!\n");
			return;
		}

		eFuse_Addr = bank * EFUSE_MAX_BANK_SIZE;

		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);

		if (efuseHeader == 0xFF && bank == startBank && Fake != TRUE) {
			RTW_INFO("Non-PGed Efuse\n");
			return;
		}
		RTW_INFO("EFUSE_REAL_CONTENT_LEN = %d\n", maprawlen);

		while ((efuseHeader != 0xFF) && ((efuseType == EFUSE_WIFI && (eFuse_Addr < maprawlen)) || (efuseType == EFUSE_BT && (eFuse_Addr < (endBank + 1) * EFUSE_MAX_BANK_SIZE)))) {

			RTW_INFO("Analyzing: Offset: 0x%X\n", eFuse_Addr);

			/* Check PG header for section num.*/
			if (EXT_HEADER(efuseHeader)) {
				bExtHeader = TRUE;
				offset_2_0 = GET_HDR_OFFSET_2_0(efuseHeader);
				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, bPseudoTest);

				if (efuseExtHdr != 0xff) {
					if (ALL_WORDS_DISABLED(efuseExtHdr)) {
						/* Read next pg header*/
						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
						continue;
					} else {
						offset = ((efuseExtHdr & 0xF0) >> 1) | offset_2_0;
						wden = (efuseExtHdr & 0x0F);
						efuseHeader2Byte = (efuseExtHdr<<8)|efuseHeader;
						RTW_INFO("Find efuseHeader2Byte = 0x%04X, offset=%d, wden=0x%x\n",
										efuseHeader2Byte, offset, wden);
					}
				} else {
					RTW_INFO("Error, efuse[%d]=0xff, efuseExtHdr=0xff\n", eFuse_Addr-1);
					break;
				}
			} else {
				offset = ((efuseHeader >> 4) & 0x0f);
				wden = (efuseHeader & 0x0f);
			}

			_rtw_memset(efuseData, '\0', EFUSE_MAX_WORD_UNIT * 2);
			dataCnt = 0;

			if (offset < max_section) {
				for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
					/* Check word enable condition in the section	*/
					if (!(wden & (0x01<<i))) {
						if (!((efuseType == EFUSE_WIFI && (eFuse_Addr + 2 < maprawlen)) ||
								(efuseType == EFUSE_BT && (eFuse_Addr + 2 < (endBank + 1) * EFUSE_MAX_BANK_SIZE)))) {
							RTW_INFO("eFuse_Addr exceeds, break\n");
							break;
						}
						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData[dataCnt++], bPseudoTest);
						eFuseWord[(offset * 8) + (i * 2)] = (efuseData[dataCnt - 1]);
						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData[dataCnt++], bPseudoTest);
						eFuseWord[(offset * 8) + (i * 2 + 1)] = (efuseData[dataCnt - 1]);
					}
				}
			}

			if (bExtHeader) {
				RTW_INFO("Efuse PG Section (%d) = ", pgSectionCnt);
				RTW_INFO("[ %04X ], [", efuseHeader2Byte);

			} else {
				RTW_INFO("Efuse PG Section (%d) = ", pgSectionCnt);
				RTW_INFO("[ %02X ], [", efuseHeader);
			}

			for (j = 0; j < dataCnt; j++)
				RTW_INFO(" %02X ", efuseData[j]);

			RTW_INFO("]\n");


			if (bExtHeader) {
				ParseEfuseExtHdr = (efuseHeader2Byte & 0xff00) >> 8;
				ParseEfuseHeader = (efuseHeader2Byte & 0xff);
				ParseOffset2_0 = GET_HDR_OFFSET_2_0(ParseEfuseHeader);
				ParseOffset = ((ParseEfuseExtHdr & 0xF0) >> 1) | ParseOffset2_0;
				ParseWDEN = (ParseEfuseExtHdr & 0x0F);
				RTW_INFO("Header=0x%x, ExtHeader=0x%x, ", ParseEfuseHeader, ParseEfuseExtHdr);
			} else {
				ParseEfuseHeader = efuseHeader;
				ParseOffset = ((ParseEfuseHeader >> 4) & 0x0f);
				ParseWDEN = (ParseEfuseHeader & 0x0f);
				RTW_INFO("Header=0x%x, ", ParseEfuseHeader);
			}
			RTW_INFO("offset=0x%x(%d), word enable=0x%x\n", ParseOffset, ParseOffset, ParseWDEN);

			wd_cnt = 0;
			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
				if (!(wden & (0x01 << i))) {
					RTW_INFO("Map[ %02X ] = %02X %02X\n", ((offset * EFUSE_MAX_WORD_UNIT * 2) + (i * 2)), efuseData[wd_cnt * 2 + 0], efuseData[wd_cnt * 2 + 1]);
					wd_cnt++;
				}
			}

			pgSectionCnt++;
			bExtHeader = FALSE;
			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
			if (efuseHeader == 0xFF) {
				if ((eFuse_Addr + protectBytesBank) >= efuse_max)
					bCheckNextBank = TRUE;
				else
					bCheckNextBank = FALSE;
			}
		}
		if (!bCheckNextBank) {
			RTW_INFO("Not need to check next bank, eFuse_Addr=%d, protectBytesBank=%d, efuse_max=%d\n",
				eFuse_Addr, protectBytesBank, efuse_max);
			break;
		}
	}
	/* switch bank back to 0 for BT/wifi later use*/
	hal_EfuseSwitchToBank(padapter, 0, bPseudoTest);

	/* 3. Collect 16 sections and 4 word unit into Efuse map.*/
	for (i = 0; i < max_section; i++) {
		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++) {
			pEfuseHal->fakeEfuseInitMap[(i*8)+(j*2)] = (eFuseWord[(i*8)+(j*2)]);
			pEfuseHal->fakeEfuseInitMap[(i*8)+((j*2)+1)] =  (eFuseWord[(i*8)+((j*2)+1)]);
		}
	}

	RTW_INFO("\n\tEFUSE Analyze Map\n");
	i = 0;
	j = 0;

	for (i = 0; i < mapLen; i++) {
		if (i % 16 == 0) {
			RTW_PRINT_SEL(RTW_DBGDUMP, "0x%03x: ", i);
			_RTW_PRINT_SEL(RTW_DBGDUMP, "%02X%s"
				, pEfuseHal->fakeEfuseInitMap[i]
				, ((i + 1) % 16 == 0) ? "\n" : (((i + 1) % 8 == 0) ? "	  " : " ")
			);
		}
	}
	_RTW_PRINT_SEL(RTW_DBGDUMP, "\n");
	if (eFuseWord)
		rtw_mfree((u8 *)eFuseWord, EFUSE_MAX_SECTION_NUM * (EFUSE_MAX_WORD_UNIT * 2));
}

VOID efuse_PreUpdateAction(
	PADAPTER	pAdapter,
	pu4Byte	BackupRegs)
{
	if (IS_HARDWARE_TYPE_8812AU(pAdapter) || IS_HARDWARE_TYPE_8822BU(pAdapter)) {
		/* <20131115, Kordan> Turn off Rx to prevent from being busy when writing the EFUSE. (Asked by Chunchu.)*/
		BackupRegs[0] = phy_query_mac_reg(pAdapter, REG_RCR, bMaskDWord);
		BackupRegs[1] = phy_query_mac_reg(pAdapter, REG_RXFLTMAP0, bMaskDWord);
		BackupRegs[2] = phy_query_mac_reg(pAdapter, REG_RXFLTMAP0+4, bMaskDWord);
#ifdef CONFIG_RTL8812A
		BackupRegs[3] = phy_query_mac_reg(pAdapter, REG_AFE_MISC, bMaskDWord);
#endif
		PlatformEFIOWrite4Byte(pAdapter, REG_RCR, 0x1);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0, 0);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0+1, 0);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0+2, 0);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0+3, 0);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0+4, 0);
		PlatformEFIOWrite1Byte(pAdapter, REG_RXFLTMAP0+5, 0);
#ifdef CONFIG_RTL8812A
		/* <20140410, Kordan> 0x11 = 0x4E, lower down LX_SPS0 voltage. (Asked by Chunchu)*/
		phy_set_mac_reg(pAdapter, REG_AFE_MISC, bMaskByte1, 0x4E);
#endif
		RTW_INFO(" %s , done\n", __func__);

		}
}


VOID efuse_PostUpdateAction(
	PADAPTER	pAdapter,
	pu4Byte	BackupRegs)
{
	if (IS_HARDWARE_TYPE_8812AU(pAdapter) || IS_HARDWARE_TYPE_8822BU(pAdapter)) {
		/* <20131115, Kordan> Turn on Rx and restore the registers. (Asked by Chunchu.)*/
		phy_set_mac_reg(pAdapter, REG_RCR, bMaskDWord, BackupRegs[0]);
		phy_set_mac_reg(pAdapter, REG_RXFLTMAP0, bMaskDWord, BackupRegs[1]);
		phy_set_mac_reg(pAdapter, REG_RXFLTMAP0+4, bMaskDWord, BackupRegs[2]);
#ifdef CONFIG_RTL8812A
		phy_set_mac_reg(pAdapter, REG_AFE_MISC, bMaskDWord, BackupRegs[3]);
#endif
	RTW_INFO(" %s , done\n", __func__);
	}
}

/* ------------------------------------------------------------------------------ */
#define REG_EFUSE_CTRL		0x0030
#define EFUSE_CTRL			REG_EFUSE_CTRL		/* E-Fuse Control. */
/* ------------------------------------------------------------------------------ */


BOOLEAN
Efuse_Read1ByteFromFakeContent(
	IN		PADAPTER	pAdapter,
	IN		u16		Offset,
	IN OUT	u8		*Value);
BOOLEAN
Efuse_Read1ByteFromFakeContent(
	IN		PADAPTER	pAdapter,
	IN		u16		Offset,
	IN OUT	u8		*Value)
{
	if (Offset >= EFUSE_MAX_HW_SIZE)
		return _FALSE;
	/* DbgPrint("Read fake content, offset = %d\n", Offset); */
	if (fakeEfuseBank == 0)
		*Value = fakeEfuseContent[Offset];
	else
		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
	return _TRUE;
}

BOOLEAN
Efuse_Write1ByteToFakeContent(
	IN		PADAPTER	pAdapter,
	IN		u16		Offset,
	IN		u8		Value);
BOOLEAN
Efuse_Write1ByteToFakeContent(
	IN		PADAPTER	pAdapter,
	IN		u16		Offset,
	IN		u8		Value)
{
	if (Offset >= EFUSE_MAX_HW_SIZE)
		return _FALSE;
	if (fakeEfuseBank == 0)
		fakeEfuseContent[Offset] = Value;
	else
		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
	return _TRUE;
}

/*-----------------------------------------------------------------------------
 * Function:	Efuse_PowerSwitch
 *
 * Overview:	When we want to enable write operation, we should change to
 *				pwr on state. When we stop write, we should switch to 500k mode
 *				and disable LDO 2.5V.
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/17/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
VOID
Efuse_PowerSwitch(
	IN	PADAPTER	pAdapter,
	IN	u8		bWrite,
	IN	u8		PwrState)
{
	pAdapter->hal_func.EfusePowerSwitch(pAdapter, bWrite, PwrState);
}

VOID
BTEfuse_PowerSwitch(
	IN	PADAPTER	pAdapter,
	IN	u8		bWrite,
	IN	u8		PwrState)
{
	if (pAdapter->hal_func.BTEfusePowerSwitch)
		pAdapter->hal_func.BTEfusePowerSwitch(pAdapter, bWrite, PwrState);
}

/*-----------------------------------------------------------------------------
 * Function:	efuse_GetCurrentSize
 *
 * Overview:	Get current efuse size!!!
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/16/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
u16
Efuse_GetCurrentSize(
	IN PADAPTER		pAdapter,
	IN u8			efuseType,
	IN BOOLEAN		bPseudoTest)
{
	u16 ret = 0;

	ret = pAdapter->hal_func.EfuseGetCurrentSize(pAdapter, efuseType, bPseudoTest);

	return ret;
}

/*
 *	Description:
 *		Execute E-Fuse read byte operation.
 *		Refered from SD1 Richard.
 *
 *	Assumption:
 *		1. Boot from E-Fuse and successfully auto-load.
 *		2. PASSIVE_LEVEL (USB interface)
 *
 *	Created by Roger, 2008.10.21.
 *   */
VOID
ReadEFuseByte(
	PADAPTER	Adapter,
	u16			_offset,
	u8			*pbuf,
	IN BOOLEAN	bPseudoTest)
{
	u32	value32;
	u8	readbyte;
	u16	retry;
	/* systime start=rtw_get_current_time(); */

	if (bPseudoTest) {
		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
		return;
	}
	if (IS_HARDWARE_TYPE_8723B(Adapter)) {
		/* <20130121, Kordan> For SMIC S55 EFUSE specificatoin. */
		/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
		phy_set_mac_reg(Adapter, EFUSE_TEST, BIT11, 0);
	}
	/* Write Address */
	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));

	/* Write bit 32 0 */
	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3);
	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));

	/* Check bit 32 read-ready */
	retry = 0;
	value32 = rtw_read32(Adapter, EFUSE_CTRL);
	/* while(!(((value32 >> 24) & 0xff) & 0x80)  && (retry<10)) */
	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
		value32 = rtw_read32(Adapter, EFUSE_CTRL);
		retry++;
	}

	/* 20100205 Joseph: Add delay suggested by SD1 Victor. */
	/* This fix the problem that Efuse read error in high temperature condition. */
	/* Designer says that there shall be some delay after ready bit is set, or the */
	/* result will always stay on last data we read. */
	rtw_udelay_os(50);
	value32 = rtw_read32(Adapter, EFUSE_CTRL);

	*pbuf = (u8)(value32 & 0xff);
	/* RTW_INFO("ReadEFuseByte _offset:%08u, in %d ms\n",_offset ,rtw_get_passing_time_ms(start)); */

}

/*
 *	Description:
 *		1. Execute E-Fuse read byte operation according as map offset and
 *		    save to E-Fuse table.
 *		2. Refered from SD1 Richard.
 *
 *	Assumption:
 *		1. Boot from E-Fuse and successfully auto-load.
 *		2. PASSIVE_LEVEL (USB interface)
 *
 *	Created by Roger, 2008.10.21.
 *
 *	2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description.
 *					2. Add efuse utilization collect.
 *	2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1
 *					write addr must be after sec5.
 *   */

VOID
efuse_ReadEFuse(
	PADAPTER	Adapter,
	u8		efuseType,
	u16		_offset,
	u16		_size_byte,
	u8	*pbuf,
	IN	BOOLEAN	bPseudoTest
);
VOID
efuse_ReadEFuse(
	PADAPTER	Adapter,
	u8		efuseType,
	u16		_offset,
	u16		_size_byte,
	u8	*pbuf,
	IN	BOOLEAN	bPseudoTest
)
{
	Adapter->hal_func.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
}

VOID
EFUSE_GetEfuseDefinition(
	IN		PADAPTER	pAdapter,
	IN		u8		efuseType,
	IN		u8		type,
	OUT		void		*pOut,
	IN		BOOLEAN		bPseudoTest
)
{
	pAdapter->hal_func.EFUSEGetEfuseDefinition(pAdapter, efuseType, type, pOut, bPseudoTest);
}


/*  11/16/2008 MH Read one byte from real Efuse. */
u8
efuse_OneByteRead(
	IN	PADAPTER	pAdapter,
	IN	u16			addr,
	IN	u8			*data,
	IN	BOOLEAN		bPseudoTest)
{
	u32	tmpidx = 0;
	u8	bResult;
	u8	readbyte;
	HAL_DATA_TYPE	*pHalData = GET_HAL_DATA(pAdapter);

	/* RTW_INFO("===> EFUSE_OneByteRead(), addr = %x\n", addr); */
	/* RTW_INFO("===> EFUSE_OneByteRead() start, 0x34 = 0x%X\n", rtw_read32(pAdapter, EFUSE_TEST)); */

	if (bPseudoTest) {
		bResult = Efuse_Read1ByteFromFakeContent(pAdapter, addr, data);
		return bResult;
	}

	if (IS_HARDWARE_TYPE_8723B(pAdapter) ||
	    (IS_HARDWARE_TYPE_8192E(pAdapter) && (!IS_A_CUT(pHalData->version_id))) ||
	    (IS_VENDOR_8188E_I_CUT_SERIES(pAdapter)) || (IS_CHIP_VENDOR_SMIC(pHalData->version_id))
	   ) {
		/* <20130121, Kordan> For SMIC EFUSE specificatoin. */
		/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8])	 */
		/* phy_set_mac_reg(pAdapter, 0x34, BIT11, 0); */
		rtw_write16(pAdapter, 0x34, rtw_read16(pAdapter, 0x34) & (~BIT11));
	}

	/* -----------------e-fuse reg ctrl --------------------------------- */
	/* address			 */
	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC));

	/* rtw_write8(pAdapter, EFUSE_CTRL+3,  0x72); */ /* read cmd	 */
	/* Write bit 32 0 */
	readbyte = rtw_read8(pAdapter, EFUSE_CTRL + 3);
	rtw_write8(pAdapter, EFUSE_CTRL + 3, (readbyte & 0x7f));

	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 1000)) {
		rtw_mdelay_os(1);
		tmpidx++;
	}
	if (tmpidx < 100) {
		*data = rtw_read8(pAdapter, EFUSE_CTRL);
		bResult = _TRUE;
	} else {
		*data = 0xff;
		bResult = _FALSE;
		RTW_INFO("%s: [ERROR] addr=0x%x bResult=%d time out 1s !!!\n", __FUNCTION__, addr, bResult);
		RTW_INFO("%s: [ERROR] EFUSE_CTRL =0x%08x !!!\n", __FUNCTION__, rtw_read32(pAdapter, EFUSE_CTRL));
	}

	return bResult;
}

/*  11/16/2008 MH Write one byte to reald Efuse. */
u8
efuse_OneByteWrite(
	IN	PADAPTER	pAdapter,
	IN	u16			addr,
	IN	u8			data,
	IN	BOOLEAN		bPseudoTest)
{
	u8	tmpidx = 0;
	u8	bResult = _FALSE;
	u32 efuseValue = 0;
	HAL_DATA_TYPE	*pHalData = GET_HAL_DATA(pAdapter);

	/* RTW_INFO("===> EFUSE_OneByteWrite(), addr = %x data=%x\n", addr, data); */
	/* RTW_INFO("===> EFUSE_OneByteWrite() start, 0x34 = 0x%X\n", rtw_read32(pAdapter, EFUSE_TEST)); */

	if (bPseudoTest) {
		bResult = Efuse_Write1ByteToFakeContent(pAdapter, addr, data);
		return bResult;
	}

	Efuse_PowerSwitch(pAdapter, _TRUE, _TRUE);

	/* -----------------e-fuse reg ctrl ---------------------------------	 */
	/* address			 */


	efuseValue = rtw_read32(pAdapter, EFUSE_CTRL);
	efuseValue |= (BIT21 | BIT31);
	efuseValue &= ~(0x3FFFF);
	efuseValue |= ((addr << 8 | data) & 0x3FFFF);

	/* <20130227, Kordan> 8192E MP chip A-cut had better not set 0x34[11] until B-Cut. */
	if (IS_HARDWARE_TYPE_8723B(pAdapter) ||
	    (IS_HARDWARE_TYPE_8192E(pAdapter) && (!IS_A_CUT(pHalData->version_id))) ||
	    (IS_VENDOR_8188E_I_CUT_SERIES(pAdapter)) || (IS_CHIP_VENDOR_SMIC(pHalData->version_id))
	   ) {
		/* <20130121, Kordan> For SMIC EFUSE specificatoin. */
		/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
		/* phy_set_mac_reg(pAdapter, 0x34, BIT11, 1); */
		rtw_write16(pAdapter, 0x34, rtw_read16(pAdapter, 0x34) | (BIT11));
		rtw_write32(pAdapter, EFUSE_CTRL, 0x90600000 | ((addr << 8 | data)));
	} else
		rtw_write32(pAdapter, EFUSE_CTRL, efuseValue);

	rtw_mdelay_os(1);

	while ((0x80 &  rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100)) {
		rtw_mdelay_os(1);
		tmpidx++;
	}

	if (tmpidx < 100)
		bResult = _TRUE;
	else {
		bResult = _FALSE;
		RTW_INFO("%s: [ERROR] addr=0x%x ,efuseValue=0x%x ,bResult=%d time out 1s !!!\n",
			 __FUNCTION__, addr, efuseValue, bResult);
		RTW_INFO("%s: [ERROR] EFUSE_CTRL =0x%08x !!!\n", __FUNCTION__, rtw_read32(pAdapter, EFUSE_CTRL));
	}

	/* disable Efuse program enable */
	if (IS_HARDWARE_TYPE_8723B(pAdapter) ||
	    (IS_HARDWARE_TYPE_8192E(pAdapter) && (!IS_A_CUT(pHalData->version_id))) ||
	    (IS_VENDOR_8188E_I_CUT_SERIES(pAdapter)) || (IS_CHIP_VENDOR_SMIC(pHalData->version_id))
	   )
		phy_set_mac_reg(pAdapter, EFUSE_TEST, BIT(11), 0);

	Efuse_PowerSwitch(pAdapter, _TRUE, _FALSE);

	return bResult;
}

int
Efuse_PgPacketRead(IN	PADAPTER	pAdapter,
		   IN	u8			offset,
		   IN	u8			*data,
		   IN	BOOLEAN		bPseudoTest)
{
	int	ret = 0;

	ret =  pAdapter->hal_func.Efuse_PgPacketRead(pAdapter, offset, data, bPseudoTest);

	return ret;
}

int
Efuse_PgPacketWrite(IN	PADAPTER	pAdapter,
		    IN	u8			offset,
		    IN	u8			word_en,
		    IN	u8			*data,
		    IN	BOOLEAN		bPseudoTest)
{
	int ret;

	ret =  pAdapter->hal_func.Efuse_PgPacketWrite(pAdapter, offset, word_en, data, bPseudoTest);

	return ret;
}


int
Efuse_PgPacketWrite_BT(IN	PADAPTER	pAdapter,
		       IN	u8			offset,
		       IN	u8			word_en,
		       IN	u8			*data,
		       IN	BOOLEAN		bPseudoTest)
{
	int ret;

	ret =  pAdapter->hal_func.Efuse_PgPacketWrite_BT(pAdapter, offset, word_en, data, bPseudoTest);

	return ret;
}


u8
Efuse_WordEnableDataWrite(IN	PADAPTER	pAdapter,
			  IN	u16		efuse_addr,
			  IN	u8		word_en,
			  IN	u8		*data,
			  IN	BOOLEAN		bPseudoTest)
{
	u8	ret = 0;

	ret =  pAdapter->hal_func.Efuse_WordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);

	return ret;
}

static u8 efuse_read8(PADAPTER padapter, u16 address, u8 *value)
{
	return efuse_OneByteRead(padapter, address, value, _FALSE);
}

static u8 efuse_write8(PADAPTER padapter, u16 address, u8 *value)
{
	return efuse_OneByteWrite(padapter, address, *value, _FALSE);
}

/*
 * read/wirte raw efuse data
 */
u8 rtw_efuse_access(PADAPTER padapter, u8 bWrite, u16 start_addr, u16 cnts, u8 *data)
{
	int i = 0;
	u16	real_content_len = 0, max_available_size = 0;
	u8 res = _FAIL ;
	u8(*rw8)(PADAPTER, u16, u8 *);
	u32	backupRegs[4] = {0};


	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (PVOID)&real_content_len, _FALSE);
	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (PVOID)&max_available_size, _FALSE);

	if (start_addr > real_content_len)
		return _FAIL;

	if (_TRUE == bWrite) {
		if ((start_addr + cnts) > max_available_size)
			return _FAIL;
		rw8 = &efuse_write8;
	} else
		rw8 = &efuse_read8;

	efuse_PreUpdateAction(padapter, backupRegs);

	Efuse_PowerSwitch(padapter, bWrite, _TRUE);

	/* e-fuse one byte read / write */
	for (i = 0; i < cnts; i++) {
		if (start_addr >= real_content_len) {
			res = _FAIL;
			break;
		}

		res = rw8(padapter, start_addr++, data++);
		if (_FAIL == res)
			break;
	}

	Efuse_PowerSwitch(padapter, bWrite, _FALSE);

	efuse_PostUpdateAction(padapter, backupRegs);

	return res;
}
/* ------------------------------------------------------------------------------ */
u16 efuse_GetMaxSize(PADAPTER padapter)
{
	u16	max_size;

	max_size = 0;
	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI , TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (PVOID)&max_size, _FALSE);
	return max_size;
}
/* ------------------------------------------------------------------------------ */
u8 efuse_GetCurrentSize(PADAPTER padapter, u16 *size)
{
	Efuse_PowerSwitch(padapter, _FALSE, _TRUE);
	*size = Efuse_GetCurrentSize(padapter, EFUSE_WIFI, _FALSE);
	Efuse_PowerSwitch(padapter, _FALSE, _FALSE);

	return _SUCCESS;
}
/* ------------------------------------------------------------------------------ */
u16 efuse_bt_GetMaxSize(PADAPTER padapter)
{
	u16	max_size;

	max_size = 0;
	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT , TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (PVOID)&max_size, _FALSE);
	return max_size;
}

u8 efuse_bt_GetCurrentSize(PADAPTER padapter, u16 *size)
{
	Efuse_PowerSwitch(padapter, _FALSE, _TRUE);
	*size = Efuse_GetCurrentSize(padapter, EFUSE_BT, _FALSE);
	Efuse_PowerSwitch(padapter, _FALSE, _FALSE);

	return _SUCCESS;
}

u8 rtw_efuse_map_read(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
	u16	mapLen = 0;

	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, _FALSE);

	if ((addr + cnts) > mapLen)
		return _FAIL;

	Efuse_PowerSwitch(padapter, _FALSE, _TRUE);

	efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, _FALSE);

	Efuse_PowerSwitch(padapter, _FALSE, _FALSE);

	return _SUCCESS;
}

u8 rtw_BT_efuse_map_read(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
	u16	mapLen = 0;

	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, _FALSE);

	if ((addr + cnts) > mapLen)
		return _FAIL;

	Efuse_PowerSwitch(padapter, _FALSE, _TRUE);

	efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, _FALSE);

	Efuse_PowerSwitch(padapter, _FALSE, _FALSE);

	return _SUCCESS;
}

/* ------------------------------------------------------------------------------ */
u8 rtw_efuse_map_write(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
#define RT_ASSERT_RET(expr)												\
	if (!(expr)) {															\
		printk("Assertion failed! %s at ......\n", #expr);							\
		printk("      ......%s,%s, line=%d\n",__FILE__, __FUNCTION__, __LINE__);	\
		return _FAIL;	\
	}

	u8 *efuse = NULL;
	u8	offset, word_en;
	u8	*map = NULL;
	u8	newdata[PGPKT_DATA_SIZE];
	s32	i, j, idx, chk_total_byte;
	u8	ret = _SUCCESS;
	u16	mapLen = 0, startAddr = 0, efuse_max_available_len = 0;
	u32	backupRegs[4] = {0};
	HAL_DATA_TYPE	*pHalData = GET_HAL_DATA(padapter);
	PEFUSE_HAL	pEfuseHal = &pHalData->EfuseHal;


	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, _FALSE);
	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_max_available_len, _FALSE);

	if ((addr + cnts) > mapLen)
		return _FAIL;

	RT_ASSERT_RET(PGPKT_DATA_SIZE == 8); /* have to be 8 byte alignment */
	RT_ASSERT_RET((mapLen & 0x7) == 0); /* have to be PGPKT_DATA_SIZE alignment for memcpy */

	efuse = rtw_zmalloc(mapLen);
	if (!efuse)
		return _FAIL;

	map = rtw_zmalloc(mapLen);
	if (map == NULL) {
		rtw_mfree(efuse, mapLen);
		return _FAIL;
	}

	_rtw_memset(map, 0xFF, mapLen);

	ret = rtw_efuse_map_read(padapter, 0, mapLen, map);
	if (ret == _FAIL)
		goto exit;

	_rtw_memcpy(efuse , map, mapLen);
	_rtw_memcpy(efuse + addr, data, cnts);

	if (padapter->registrypriv.boffefusemask == 0) {
		for (i = 0; i < cnts; i++) {
			if (padapter->registrypriv.bFileMaskEfuse == _TRUE) {
				if (rtw_file_efuse_IsMasked(padapter, addr + i))	/*use file efuse mask. */
					efuse[addr + i] = map[addr + i];
			} else {
				if (efuse_IsMasked(padapter, addr + i))
					efuse[addr + i] = map[addr + i];
			}
			RTW_INFO("%s , data[%d] = %x, map[addr+i]= %x\n", __func__, addr + i, efuse[ addr + i], map[addr + i]);
		}
	}
	/*Efuse_PowerSwitch(padapter, _TRUE, _TRUE);*/

	chk_total_byte = 0;
	idx = 0;
	offset = (addr >> 3);

	while (idx < cnts) {
		word_en = 0xF;
		j = (addr + idx) & 0x7;
		for (i = j; i < PGPKT_DATA_SIZE && idx < cnts; i++, idx++) {
			if (efuse[addr + idx] != map[addr + idx])
				word_en &= ~BIT(i >> 1);
		}

		if (word_en != 0xF) {
			chk_total_byte += Efuse_CalculateWordCnts(word_en) * 2;

			if (offset >= EFUSE_MAX_SECTION_BASE) /* Over EFUSE_MAX_SECTION 16 for 2 ByteHeader */
				chk_total_byte += 2;
			else
				chk_total_byte += 1;
		}

		offset++;
	}

	RTW_INFO("Total PG bytes Count = %d\n", chk_total_byte);
	rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);

	if (startAddr == 0) {
		startAddr = Efuse_GetCurrentSize(padapter, EFUSE_WIFI, _FALSE);
		RTW_INFO("%s: Efuse_GetCurrentSize startAddr=%#X\n", __func__, startAddr);
	}
	RTW_DBG("%s: startAddr=%#X\n", __func__, startAddr);

	if ((startAddr + chk_total_byte) >= efuse_max_available_len) {
		RTW_INFO("%s: startAddr(0x%X) + PG data len %d >= efuse_max_available_len(0x%X)\n",
			 __func__, startAddr, chk_total_byte, efuse_max_available_len);
		ret = _FAIL;
		goto exit;
	}

	efuse_PreUpdateAction(padapter, backupRegs);

	idx = 0;
	offset = (addr >> 3);
	while (idx < cnts) {
		word_en = 0xF;
		j = (addr + idx) & 0x7;
		_rtw_memcpy(newdata, &map[offset << 3], PGPKT_DATA_SIZE);
		for (i = j; i < PGPKT_DATA_SIZE && idx < cnts; i++, idx++) {
			if (efuse[addr + idx] != map[addr + idx]) {
				word_en &= ~BIT(i >> 1);
				newdata[i] = efuse[addr + idx];
#ifdef CONFIG_RTL8723B
				if (addr + idx == 0x8) {
					if (IS_C_CUT(pHalData->version_id) || IS_B_CUT(pHalData->version_id)) {
						if (pHalData->adjuseVoltageVal == 6) {
							newdata[i] = map[addr + idx];
							RTW_INFO(" %s ,\n adjuseVoltageVal = %d ,newdata[%d] = %x\n", __func__, pHalData->adjuseVoltageVal, i, newdata[i]);
						}
					}
				}
#endif
			}
		}

		if (word_en != 0xF) {
			ret = Efuse_PgPacketWrite(padapter, offset, word_en, newdata, _FALSE);
			RTW_INFO("offset=%x\n", offset);
			RTW_INFO("word_en=%x\n", word_en);

			for (i = 0; i < PGPKT_DATA_SIZE; i++)
				RTW_INFO("data=%x \t", newdata[i]);
			if (ret == _FAIL)
				break;
		}

		offset++;
	}

	/*Efuse_PowerSwitch(padapter, _TRUE, _FALSE);*/

	efuse_PostUpdateAction(padapter, backupRegs);

exit:

	rtw_mfree(map, mapLen);
	rtw_mfree(efuse, mapLen);

	return ret;
}


u8 rtw_BT_efuse_map_write(PADAPTER padapter, u16 addr, u16 cnts, u8 *data)
{
#define RT_ASSERT_RET(expr)												\
	if (!(expr)) {															\
		printk("Assertion failed! %s at ......\n", #expr);							\
		printk("      ......%s,%s, line=%d\n",__FILE__, __FUNCTION__, __LINE__);	\
		return _FAIL;	\
	}

	u8	offset, word_en;
	u8	*map;
	u8	newdata[PGPKT_DATA_SIZE];
	s32	i = 0, j = 0, idx;
	u8	ret = _SUCCESS;
	u16	mapLen = 0;

	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, _FALSE);

	if ((addr + cnts) > mapLen)
		return _FAIL;

	RT_ASSERT_RET(PGPKT_DATA_SIZE == 8); /* have to be 8 byte alignment */
	RT_ASSERT_RET((mapLen & 0x7) == 0); /* have to be PGPKT_DATA_SIZE alignment for memcpy */

	map = rtw_zmalloc(mapLen);
	if (map == NULL)
		return _FAIL;

	ret = rtw_BT_efuse_map_read(padapter, 0, mapLen, map);
	if (ret == _FAIL)
		goto exit;
	RTW_INFO("OFFSET\tVALUE(hex)\n");
	for (i = 0; i < 1024; i += 16) { /* set 512 because the iwpriv's extra size have limit 0x7FF */
		RTW_INFO("0x%03x\t", i);
		for (j = 0; j < 8; j++)
			RTW_INFO("%02X ", map[i + j]);
		RTW_INFO("\t");
		for (; j < 16; j++)
			RTW_INFO("%02X ", map[i + j]);
		RTW_INFO("\n");
	}
	RTW_INFO("\n");
	Efuse_PowerSwitch(padapter, _TRUE, _TRUE);

	idx = 0;
	offset = (addr >> 3);
	while (idx < cnts) {
		word_en = 0xF;
		j = (addr + idx) & 0x7;
		_rtw_memcpy(newdata, &map[offset << 3], PGPKT_DATA_SIZE);
		for (i = j; i < PGPKT_DATA_SIZE && idx < cnts; i++, idx++) {
			if (data[idx] != map[addr + idx]) {
				word_en &= ~BIT(i >> 1);
				newdata[i] = data[idx];
			}
		}

		if (word_en != 0xF) {
			RTW_INFO("offset=%x\n", offset);
			RTW_INFO("word_en=%x\n", word_en);
			RTW_INFO("%s: data=", __FUNCTION__);
			for (i = 0; i < PGPKT_DATA_SIZE; i++)
				RTW_INFO("0x%02X ", newdata[i]);
			RTW_INFO("\n");
			ret = Efuse_PgPacketWrite_BT(padapter, offset, word_en, newdata, _FALSE);
			if (ret == _FAIL)
				break;
		}

		offset++;
	}

	Efuse_PowerSwitch(padapter, _TRUE, _FALSE);

exit:

	rtw_mfree(map, mapLen);

	return ret;
}

/*-----------------------------------------------------------------------------
 * Function:	Efuse_ReadAllMap
 *
 * Overview:	Read All Efuse content
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/11/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
VOID
Efuse_ReadAllMap(
	IN		PADAPTER	pAdapter,
	IN		u8		efuseType,
	IN OUT	u8		*Efuse,
	IN		BOOLEAN		bPseudoTest);
VOID
Efuse_ReadAllMap(
	IN		PADAPTER	pAdapter,
	IN		u8		efuseType,
	IN OUT	u8		*Efuse,
	IN		BOOLEAN		bPseudoTest)
{
	u16	mapLen = 0;

	Efuse_PowerSwitch(pAdapter, _FALSE, _TRUE);

	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, bPseudoTest);

	efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, bPseudoTest);

	Efuse_PowerSwitch(pAdapter, _FALSE, _FALSE);
}

/*-----------------------------------------------------------------------------
 * Function:	efuse_ShadowWrite1Byte
 *			efuse_ShadowWrite2Byte
 *			efuse_ShadowWrite4Byte
 *
 * Overview:	Write efuse modify map by one/two/four byte.
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/12/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
#ifdef PLATFORM
static VOID
efuse_ShadowWrite1Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN	u8		Value);
#endif /* PLATFORM */
static VOID
efuse_ShadowWrite1Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN	u8		Value)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	pHalData->efuse_eeprom_data[Offset] = Value;

}	/* efuse_ShadowWrite1Byte */

/* ---------------Write Two Bytes */
static VOID
efuse_ShadowWrite2Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN	u16		Value)
{

	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);


	pHalData->efuse_eeprom_data[Offset] = Value & 0x00FF;
	pHalData->efuse_eeprom_data[Offset + 1] = Value >> 8;

}	/* efuse_ShadowWrite1Byte */

/* ---------------Write Four Bytes */
static VOID
efuse_ShadowWrite4Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN	u32		Value)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	pHalData->efuse_eeprom_data[Offset] = (u8)(Value & 0x000000FF);
	pHalData->efuse_eeprom_data[Offset + 1] = (u8)((Value >> 8) & 0x0000FF);
	pHalData->efuse_eeprom_data[Offset + 2] = (u8)((Value >> 16) & 0x00FF);
	pHalData->efuse_eeprom_data[Offset + 3] = (u8)((Value >> 24) & 0xFF);

}	/* efuse_ShadowWrite1Byte */


/*-----------------------------------------------------------------------------
 * Function:	EFUSE_ShadowWrite
 *
 * Overview:	Write efuse modify map for later update operation to use!!!!!
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/12/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
VOID
EFUSE_ShadowWrite(
	IN	PADAPTER	pAdapter,
	IN	u8		Type,
	IN	u16		Offset,
	IN OUT	u32		Value);
VOID
EFUSE_ShadowWrite(
	IN	PADAPTER	pAdapter,
	IN	u8		Type,
	IN	u16		Offset,
	IN OUT	u32		Value)
{
#if (MP_DRIVER == 0)
	return;
#endif
	if (pAdapter->registrypriv.mp_mode == 0)
		return;


	if (Type == 1)
		efuse_ShadowWrite1Byte(pAdapter, Offset, (u8)Value);
	else if (Type == 2)
		efuse_ShadowWrite2Byte(pAdapter, Offset, (u16)Value);
	else if (Type == 4)
		efuse_ShadowWrite4Byte(pAdapter, Offset, (u32)Value);

}	/* EFUSE_ShadowWrite */

VOID
Efuse_InitSomeVar(
	IN		PADAPTER	pAdapter
);
VOID
Efuse_InitSomeVar(
	IN		PADAPTER	pAdapter
)
{
	u8 i;

	_rtw_memset((PVOID)&fakeEfuseContent[0], 0xff, EFUSE_MAX_HW_SIZE);
	_rtw_memset((PVOID)&fakeEfuseInitMap[0], 0xff, EFUSE_MAX_MAP_LEN);
	_rtw_memset((PVOID)&fakeEfuseModifiedMap[0], 0xff, EFUSE_MAX_MAP_LEN);

	for (i = 0; i < EFUSE_MAX_BT_BANK; i++)
		_rtw_memset((PVOID)&BTEfuseContent[i][0], 0xff, EFUSE_MAX_HW_SIZE);
	_rtw_memset((PVOID)&BTEfuseInitMap[0], 0xff, EFUSE_BT_MAX_MAP_LEN);
	_rtw_memset((PVOID)&BTEfuseModifiedMap[0], 0xff, EFUSE_BT_MAX_MAP_LEN);

	for (i = 0; i < EFUSE_MAX_BT_BANK; i++)
		_rtw_memset((PVOID)&fakeBTEfuseContent[i][0], 0xff, EFUSE_MAX_HW_SIZE);
	_rtw_memset((PVOID)&fakeBTEfuseInitMap[0], 0xff, EFUSE_BT_MAX_MAP_LEN);
	_rtw_memset((PVOID)&fakeBTEfuseModifiedMap[0], 0xff, EFUSE_BT_MAX_MAP_LEN);
}

/*-----------------------------------------------------------------------------
 * Function:	efuse_ShadowRead1Byte
 *			efuse_ShadowRead2Byte
 *			efuse_ShadowRead4Byte
 *
 * Overview:	Read from efuse init map by one/two/four bytes !!!!!
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/12/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
static VOID
efuse_ShadowRead1Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN OUT	u8		*Value)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	*Value = pHalData->efuse_eeprom_data[Offset];

}	/* EFUSE_ShadowRead1Byte */

/* ---------------Read Two Bytes */
static VOID
efuse_ShadowRead2Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN OUT	u16		*Value)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	*Value = pHalData->efuse_eeprom_data[Offset];
	*Value |= pHalData->efuse_eeprom_data[Offset + 1] << 8;

}	/* EFUSE_ShadowRead2Byte */

/* ---------------Read Four Bytes */
static VOID
efuse_ShadowRead4Byte(
	IN	PADAPTER	pAdapter,
	IN	u16		Offset,
	IN OUT	u32		*Value)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);

	*Value = pHalData->efuse_eeprom_data[Offset];
	*Value |= pHalData->efuse_eeprom_data[Offset + 1] << 8;
	*Value |= pHalData->efuse_eeprom_data[Offset + 2] << 16;
	*Value |= pHalData->efuse_eeprom_data[Offset + 3] << 24;

}	/* efuse_ShadowRead4Byte */

/*-----------------------------------------------------------------------------
 * Function:	EFUSE_ShadowRead
 *
 * Overview:	Read from pHalData->efuse_eeprom_data
 *---------------------------------------------------------------------------*/
void
EFUSE_ShadowRead(
	IN		PADAPTER	pAdapter,
	IN		u8		Type,
	IN		u16		Offset,
	IN OUT	u32		*Value)
{
	if (Type == 1)
		efuse_ShadowRead1Byte(pAdapter, Offset, (u8 *)Value);
	else if (Type == 2)
		efuse_ShadowRead2Byte(pAdapter, Offset, (u16 *)Value);
	else if (Type == 4)
		efuse_ShadowRead4Byte(pAdapter, Offset, (u32 *)Value);

}	/* EFUSE_ShadowRead */

/*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
u8
Efuse_CalculateWordCnts(IN u8	word_en)
{
	u8 word_cnts = 0;
	if (!(word_en & BIT(0)))
		word_cnts++; /* 0 : write enable */
	if (!(word_en & BIT(1)))
		word_cnts++;
	if (!(word_en & BIT(2)))
		word_cnts++;
	if (!(word_en & BIT(3)))
		word_cnts++;
	return word_cnts;
}

/*-----------------------------------------------------------------------------
 * Function:	efuse_WordEnableDataRead
 *
 * Overview:	Read allowed word in current efuse section data.
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/16/2008	MHC		Create Version 0.
 * 11/21/2008	MHC		Fix Write bug when we only enable late word.
 *
 *---------------------------------------------------------------------------*/
void
efuse_WordEnableDataRead(IN	u8	word_en,
			 IN	u8	*sourdata,
			 IN	u8	*targetdata)
{
	if (!(word_en & BIT(0))) {
		targetdata[0] = sourdata[0];
		targetdata[1] = sourdata[1];
	}
	if (!(word_en & BIT(1))) {
		targetdata[2] = sourdata[2];
		targetdata[3] = sourdata[3];
	}
	if (!(word_en & BIT(2))) {
		targetdata[4] = sourdata[4];
		targetdata[5] = sourdata[5];
	}
	if (!(word_en & BIT(3))) {
		targetdata[6] = sourdata[6];
		targetdata[7] = sourdata[7];
	}
}

/*-----------------------------------------------------------------------------
 * Function:	EFUSE_ShadowMapUpdate
 *
 * Overview:	Transfer current EFUSE content to shadow init and modify map.
 *
 * Input:       NONE
 *
 * Output:      NONE
 *
 * Return:      NONE
 *
 * Revised History:
 * When			Who		Remark
 * 11/13/2008	MHC		Create Version 0.
 *
 *---------------------------------------------------------------------------*/
void EFUSE_ShadowMapUpdate(
	IN PADAPTER	pAdapter,
	IN u8		efuseType,
	IN BOOLEAN	bPseudoTest)
{
	PHAL_DATA_TYPE pHalData = GET_HAL_DATA(pAdapter);
	u16	mapLen = 0;
	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (PVOID)&mapLen, bPseudoTest);

	if (pHalData->bautoload_fail_flag == _TRUE)
		_rtw_memset(pHalData->efuse_eeprom_data, 0xFF, mapLen);
	else {
#ifdef CONFIG_ADAPTOR_INFO_CACHING_FILE
		if (_SUCCESS != retriveAdaptorInfoFile(pAdapter->registrypriv.adaptor_info_caching_file_path, pHalData->efuse_eeprom_data)) {
#endif

			Efuse_ReadAllMap(pAdapter, efuseType, pHalData->efuse_eeprom_data, bPseudoTest);

#ifdef CONFIG_ADAPTOR_INFO_CACHING_FILE
			storeAdaptorInfoFile(pAdapter->registrypriv.adaptor_info_caching_file_path, pHalData->efuse_eeprom_data);
		}
#endif
	}

	rtw_mask_map_read(pAdapter, 0x00, mapLen, pHalData->efuse_eeprom_data);

	rtw_dump_cur_efuse(pAdapter);
} /* EFUSE_ShadowMapUpdate */

const u8 _mac_hidden_max_bw_to_hal_bw_cap[MAC_HIDDEN_MAX_BW_NUM] = {
	0,
	0,
	(BW_CAP_160M | BW_CAP_80M | BW_CAP_40M | BW_CAP_20M | BW_CAP_10M | BW_CAP_5M),
	(BW_CAP_5M),
	(BW_CAP_10M | BW_CAP_5M),
	(BW_CAP_20M | BW_CAP_10M | BW_CAP_5M),
	(BW_CAP_40M | BW_CAP_20M | BW_CAP_10M | BW_CAP_5M),
	(BW_CAP_80M | BW_CAP_40M | BW_CAP_20M | BW_CAP_10M | BW_CAP_5M),
};

const u8 _mac_hidden_proto_to_hal_proto_cap[MAC_HIDDEN_PROTOCOL_NUM] = {
	0,
	0,
	(PROTO_CAP_11N | PROTO_CAP_11G | PROTO_CAP_11B),
	(PROTO_CAP_11AC | PROTO_CAP_11N | PROTO_CAP_11G | PROTO_CAP_11B),
};

u8 mac_hidden_wl_func_to_hal_wl_func(u8 func)
{
	u8 wl_func = 0;

	if (func & BIT0)
		wl_func |= WL_FUNC_MIRACAST;
	if (func & BIT1)
		wl_func |= WL_FUNC_P2P;
	if (func & BIT2)
		wl_func |= WL_FUNC_TDLS;
	if (func & BIT3)
		wl_func |= WL_FUNC_FTM;

	return wl_func;
}

#ifdef PLATFORM_LINUX
#ifdef CONFIG_ADAPTOR_INFO_CACHING_FILE
/* #include <rtw_eeprom.h> */

int isAdaptorInfoFileValid(void)
{
	return _TRUE;
}

int storeAdaptorInfoFile(char *path, u8 *efuse_data)
{
	int ret = _SUCCESS;

	if (path && efuse_data) {
		ret = rtw_store_to_file(path, efuse_data, EEPROM_MAX_SIZE_512);
		if (ret == EEPROM_MAX_SIZE)
			ret = _SUCCESS;
		else
			ret = _FAIL;
	} else {
		RTW_INFO("%s NULL pointer\n", __FUNCTION__);
		ret =  _FAIL;
	}
	return ret;
}

int retriveAdaptorInfoFile(char *path, u8 *efuse_data)
{
	int ret = _SUCCESS;
	mm_segment_t oldfs;
	struct file *fp;

	if (path && efuse_data) {

		ret = rtw_retrieve_from_file(path, efuse_data, EEPROM_MAX_SIZE);

		if (ret == EEPROM_MAX_SIZE)
			ret = _SUCCESS;
		else
			ret = _FAIL;

#if 0
		if (isAdaptorInfoFileValid())
			return 0;
		else
			return _FAIL;
#endif

	} else {
		RTW_INFO("%s NULL pointer\n", __FUNCTION__);
		ret = _FAIL;
	}
	return ret;
}
#endif /* CONFIG_ADAPTOR_INFO_CACHING_FILE */

u8 rtw_efuse_file_read(PADAPTER padapter, u8 *filepatch, u8 *buf, u32 len)
{
	char *ptmpbuf = NULL, *ptr;
	u8 val8;
	u32 count, i, j;
	int err;
	u32 bufsize = 4096;

	ptmpbuf = rtw_zmalloc(bufsize);
	if (ptmpbuf == NULL)
		return _FALSE;

	count = rtw_retrieve_from_file(filepatch, ptmpbuf, bufsize);
	if (count <= 90) {
		rtw_mfree(ptmpbuf, bufsize);
		RTW_ERR("%s, filepatch %s, size=%d, FAIL!!\n", __FUNCTION__, filepatch, count);
		return _FALSE;
	}

	i = 0;
	j = 0;
	ptr = ptmpbuf;
	while ((j < len) && (i < count)) {
		if (ptmpbuf[i] == '\0')
			break;
	
		ptr = strpbrk(&ptmpbuf[i], " \t\n\r");
		if (ptr) {
			if (ptr == &ptmpbuf[i]) {
				i++;
				continue;
			}

			/* Add string terminating null */
			*ptr = 0;
		} else {
			ptr = &ptmpbuf[count-1];
		}

		err = sscanf(&ptmpbuf[i], "%hhx", &val8);
		if (err != 1) {
			RTW_WARN("Something wrong to parse efuse file, string=%s\n", &ptmpbuf[i]);
		} else {
			buf[j] = val8;
			RTW_DBG("i=%d, j=%d, 0x%02x\n", i, j, buf[j]);
			j++;
		}

		i = ptr - ptmpbuf + 1;
	}

	rtw_mfree(ptmpbuf, bufsize);
	RTW_INFO("%s, filepatch %s, size=%d, done\n", __FUNCTION__, filepatch, count);
	return _TRUE;
}

#ifdef CONFIG_EFUSE_CONFIG_FILE
u32 rtw_read_efuse_from_file(const char *path, u8 *buf, int map_size)
{
	u32 i;
	u8 c;
	u8 temp[3];
	u8 temp_i;
	u8 end = _FALSE;
	u32 ret = _FAIL;

	u8 *file_data = NULL;
	u32 file_size, read_size, pos = 0;
	u8 *map = NULL;

	if (rtw_is_file_readable_with_size(path, &file_size) != _TRUE) {
		RTW_PRINT("%s %s is not readable\n", __func__, path);
		goto exit;
	}

	file_data = vmalloc(file_size);
	if (!file_data) {
		RTW_ERR("%s vmalloc(%d) fail\n", __func__, file_size);
		goto exit;
	}

	read_size = rtw_retrieve_from_file(path, file_data, file_size);
	if (read_size == 0) {
		RTW_ERR("%s read from %s fail\n", __func__, path);
		goto exit;
	}

	map = vmalloc(map_size);
	if (!map) {
		RTW_ERR("%s vmalloc(%d) fail\n", __func__, map_size);
		goto exit;
	}
	_rtw_memset(map, 0xff, map_size);

	temp[2] = 0; /* end of string '\0' */

	for (i = 0 ; i < map_size ; i++) {
		temp_i = 0;

		while (1) {
			if (pos >= read_size) {
				end = _TRUE;
				break;
			}
			c = file_data[pos++];

			/* bypass spece or eol or null before first hex digit */
			if (temp_i == 0 && (is_eol(c) == _TRUE || is_space(c) == _TRUE || is_null(c) == _TRUE))
				continue;

			if (IsHexDigit(c) == _FALSE) {
				RTW_ERR("%s invalid 8-bit hex format for offset:0x%03x\n", __func__, i);
				goto exit;
			}

			temp[temp_i++] = c;

			if (temp_i == 2) {
				/* parse value */
				if (sscanf(temp, "%hhx", &map[i]) != 1) {
					RTW_ERR("%s sscanf fail for offset:0x%03x\n", __func__, i);
					goto exit;
				}
				break;
			}
		}

		if (end == _TRUE) {
			if (temp_i != 0) {
				RTW_ERR("%s incomplete 8-bit hex format for offset:0x%03x\n", __func__, i);
				goto exit;
			}
			break;
		}
	}

	RTW_PRINT("efuse file:%s, 0x%03x byte content read\n", path, i);

	_rtw_memcpy(buf, map, map_size);

	ret = _SUCCESS;

exit:
	if (file_data)
		rtw_vmfree(file_data, file_size);
	if (map)
		rtw_vmfree(map, map_size);

	return ret;
}

u32 rtw_read_macaddr_from_file(const char *path, u8 *buf)
{
	u32 i;
	u8 temp[3];
	u32 ret = _FAIL;

	u8 file_data[17];
	u32 read_size, pos = 0;
	u8 addr[ETH_ALEN];

	if (rtw_is_file_readable(path) != _TRUE) {
		RTW_PRINT("%s %s is not readable\n", __func__, path);
		goto exit;
	}

	read_size = rtw_retrieve_from_file(path, file_data, 17);
	if (read_size != 17) {
		RTW_ERR("%s read from %s fail\n", __func__, path);
		goto exit;
	}

	temp[2] = 0; /* end of string '\0' */

	for (i = 0 ; i < ETH_ALEN ; i++) {
		if (IsHexDigit(file_data[i * 3]) == _FALSE || IsHexDigit(file_data[i * 3 + 1]) == _FALSE) {
			RTW_ERR("%s invalid 8-bit hex format for address offset:%u\n", __func__, i);
			goto exit;
		}

		if (i < ETH_ALEN - 1 && file_data[i * 3 + 2] != ':') {
			RTW_ERR("%s invalid separator after address offset:%u\n", __func__, i);
			goto exit;
		}

		temp[0] = file_data[i * 3];
		temp[1] = file_data[i * 3 + 1];
		if (sscanf(temp, "%hhx", &addr[i]) != 1) {
			RTW_ERR("%s sscanf fail for address offset:0x%03x\n", __func__, i);
			goto exit;
		}
	}

	_rtw_memcpy(buf, addr, ETH_ALEN);

	RTW_PRINT("wifi_mac file: %s\n", path);
#ifdef CONFIG_RTW_DEBUG
	RTW_INFO(MAC_FMT"\n", MAC_ARG(buf));
#endif

	ret = _SUCCESS;

exit:
	return ret;
}
#endif /* CONFIG_EFUSE_CONFIG_FILE */

#endif /* PLATFORM_LINUX */
